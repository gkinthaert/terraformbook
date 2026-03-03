# set the provider

provider "aws" {
  region = "us-east-2"
}

# setup of EC2 instance

resource "aws_instance" "example" {
  ami           = "ami-09256c524fab91d36"
  instance_type = "t3.micro"

  tags = {
    Name = "example-ec2-instance"
  }
}