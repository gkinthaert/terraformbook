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

# deploying a web server

resource "aws_instance" "web_server" {
  ami           = "ami-09256c524fab91d36"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  tags = {
    Name = "web-server-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Welcome to the Web Server</h1>" > /var/www/html/index.html
              EOF
  user_data_replace_on_change = true

}

# security group for the web server

resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP traffic to web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}