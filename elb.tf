# Create a new load balancer
resource "aws_elb" "cloudops_elb" {
  name               = "terraform-elb"
  #availability_zones = ["us-west-2a", "us-west-2b"]
 subnets = ["${aws_subnet.cloudops_public_subnet_1.id}","${aws_subnet.cloudops_public_subnet_2.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = ["${aws_instance.instance_web_1.id}","${aws_instance.instance_web_2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "terraform-elb"
  }
}
