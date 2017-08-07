resource "aws_security_group" "cloudops_security_group" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id     = "${aws_vpc.cloudops_vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
