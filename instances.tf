resource "aws_instance" "nat_instance" {
    ami = "${var.NAT_AMI_ID}"
    instance_type = "${var.AWS_NAT_INSTANCE_TYPE}"
    source_dest_check = false
    availability_zone = "us-west-2a"
    subnet_id = "${aws_subnet.cloudops_public_subnet_1.id}"
    key_name = "awskey2"
       tags {
      Name = "NATInstance"
    }
}

resource "aws_instance" "instance_web_1" {
    ami = "${var.EC2_AMI_ID}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    availability_zone = "us-west-2a"
    subnet_id = "${aws_subnet.cloudops_public_subnet_1.id}"
    key_name = "awskey2"
    user_data = <<EOF
                 #! /bin/bash
                 yum install httpd -y
                 service httpd start
                 echo "<h1>Welcome to webserver 1</h1>" > /var/www/html/index.html
                 chkconfig httpd on
                EOF
    tags {
      Name = "WebServer-1"
    }
}

resource "aws_instance" "instance_web_2" {
    ami = "${var.EC2_AMI_ID}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    availability_zone = "us-west-2b"
    subnet_id = "${aws_subnet.cloudops_public_subnet_2.id}"
    key_name = "awskey2"
    user_data = <<EOF
                 #! /bin/bash
                 yum install httpd -y
                 service httpd start
                 echo "<h1>Welcome to webserver 2</h1>" > /var/www/html/index.html
                 chkconfig httpd on
                EOF
    tags {
      Name = "WebServer-2"
    }
}

resource "aws_instance" "Private_instance" {
    ami = "${var.EC2_AMI_ID}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    availability_zone = "us-west-2c"
    subnet_id = "${aws_subnet.cloudops_private_subnet_1.id}"
    key_name = "awskey2"
    user_data = <<EOF
                 #! /bin/bash
                 yum install httpd -y
                 service httpd start
                 echo "<h1>Welcome to Private Instance</h1>" > /var/www/html/index.html
                 chkconfig httpd on
                EOF
    tags {
      Name = "Private Instance"
    }
}








# terraform {
#   backend "s3" {
#     bucket = "cloudops-terraform-state-prod"
#     key    = "cloudops"
#     region = "us-west-2"
#   }
# }
