##General vars
variable "ssh_user" {
  default = "ubuntu"
}

##AWS Specific Vars
variable "aws_worker_count" {
  default = 2
}
variable "swarm-master" {
  default = 1
}
variable "aws_key_name" {
  default = "aigerim1"
}
variable "aws_instance_size" {
  default = "t2.micro"
}
variable "aws_region" {
  default = "us-east-2"
}
