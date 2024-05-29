##Amazon Infrastructure

provider "aws" {
  region = "us-east-2"
}

variable "instance_count" {
  default = 3
}

variable "ami" {
  default = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "aigerim1"
}


##Create swarm security group
resource "aws_security_group" "swarm_sg" {
  name        = "swarm_sg"
  description = "Allow all inbound traffic necessary for Swarm"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

##Create Swarm Master Instance
resource "aws_instance" "swarm-master" {
  depends_on             = ["aws_security_group.swarm_sg"]
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "${var.aws_instance_size}"
  vpc_security_group_ids = ["${aws_security_group.swarm_sg.id}"]
  key_name               = "${var.aws_key_name}"
  count                  = "${var.aws_swarm-master}"
  tags {
    Name = "swarm-master"
  }
}

##Create AWS Swarm Workers
resource "aws_instance" "aws-swarm-member" {
  depends_on             = ["aws_security_group.swarm_sg"]
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "${var.aws_instance_size}"
  vpc_security_group_ids = ["${aws_security_group.swarm_sg.id}"]
  key_name               = "aigerim1"
  count                  = "${var.aws_worker_count}"
  tags {
    Name = "swarm-member${count.index}"
  }
}
