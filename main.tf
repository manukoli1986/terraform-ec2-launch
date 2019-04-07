
provider "aws" {
  region                  = "${var.aws_region}"
  access_key 		  = "${var.aws_access_key}"
  secret_key 		  = "${var.aws_secret_key}"
  profile                 = "terraform"
}

resource "aws_instance" "ansible-docker" {
  ami = "ami-0889b8a448de4fc44"
  instance_type = "t2.micro"
  user_data = "${file("tomcatstack.sh")}"

  tags {
    Environment = "Dev"
    server = "tomcat-stack"
    name= "ansible-aws-web"
  }
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # add your IP address here
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ec2_global_ips" {
  value = ["${aws_instance.ansible-docker.*.public_ip}"]
}
