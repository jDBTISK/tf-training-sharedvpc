# vpc endpoint privatelink scg
resource "aws_security_group" "vpce" {
  name        = "vpce-privatelink"
  description = "allow vpc endpoint privatelink traffic."

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name_tag_prefix}-scg"
  }
}

resource "aws_security_group_rule" "vpce_inbound" {
  type              = "ingress"
  description       = "allow https inbound from training vpc"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.vpce.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "vpce_outbound" {
  type              = "egress"
  description       = "allow https outbound to training vpc"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.vpce.id

  lifecycle {
    create_before_destroy = true
  }
}
