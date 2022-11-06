################################################################################
# AWS alb for ESC service
################################################################################
resource "aws_lb" "this" {
  name               = "${var.service_name}-alb"
  internal           = var.expose_to_public_internet == "yes" ? false : true
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups = [
    aws_security_group.load_balancer.id
  ]

  enable_deletion_protection = false

  dynamic "access_logs" {
    for_each = var.access_logs_bucket != "" ? [1] : []
    content {
      bucket  = var.access_logs_bucket
      prefix  = var.access_logs_bucket_prefix
      enabled = var.store_access_logs == "yes" ? true : false
    }
  }

  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Service     = var.service_name
      Name        = "${var.service_name}-alb"
    }
  )
}

resource "aws_alb_target_group" "this" {
  name        = "${var.service_name}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Service     = var.service_name
      Name        = "${var.service_name}-target-group"
    }
  )
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.this.id
    type             = "forward"
  }

  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Service     = var.service_name
      Name        = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}"
    }
  )
}


################################################################################
# Security group and rules for alb
################################################################################

data "aws_vpc" "this" {
  id = var.vpc_id
}

resource "aws_security_group" "load_balancer" {
  name        = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}-alb-sg"
  vpc_id      = var.vpc_id
  description = "ALB for service ${var.service_name}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allow_cidrs
  }

  egress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = coalescelist(var.egress_cidrs, [data.aws_vpc.this.cidr_block])
  }
}

resource "aws_security_group" "open_to_load_balancer" {
  name        = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}--alb-open-sg"
  vpc_id      = var.vpc_id
  description = "Open to service: ${var.service_name}"

  ingress {
    from_port = var.service_port
    to_port   = var.service_port
    protocol  = "tcp"
    security_groups = [
      aws_security_group.load_balancer.id
    ]
  }
}
