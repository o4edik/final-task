# Create EC2 instances with linux
# Output public_ip



provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
  }

resource "aws_key_pair" "idrsa" {
    key_name = "id_rsa"
    public_key = var.public_key
}


resource "aws_instance" "webprod" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.webserver.id]
  key_name = "id_rsa"
  
  tags = {
    Name = "Prod_Env"
  }
}

resource "aws_security_group" "webserver" {
  name        = "allow_all"
  description = "Allow inbound traffic"

 ingress {
    description      = "ICMP"
    from_port        = 8
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
}

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "http/s/, ssh"
  }
}

output "Prod_Env_publicIP" {
    value = aws_instance.webprod.public_ip
}


  
