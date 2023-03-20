# Create key pair
resource "aws_key_pair" "project-key" {
  key_name   = "project-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMkXRatNb6YHDZtEE9NGyU90+Y48YXMRMjclRw/UC1tvPra4n2RlgJQr4gUZlaasN3TG2rsXPIAW7VlB9WClRyjaDqCK1elho0za72PxanP1mXTYNPJoTl0fjqM01G575tXz5oUeq7FpujggJfGsKUEYFnhWVS3Vh+ZEnuGiprFTJ9x23or+JDPxEvYbWG2tVIARnNneL1ipsxY8pKboQVei74ScB28JLtys/CDlzBDO2lQYRXagfle9FqBXhCWkPv4PYiN0BnQ9JtwWhlUhvGDQOafGWr9gX3NY8N6IUq/jmHXYDN1LbD6zzAxNrLRnQgmG4yVg0KYn+QiLaKcTfD"
}

# Create instances in each subnet
resource "aws_instance" "my-project-master" {
  ami                    = "ami-0e735aba742568824"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.my-project-public-subnet-1.id
  associate_public_ip_address = true
  key_name               = "${aws_key_pair.project-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.my-project-public-sg.id}"]

  tags = {
    Name = "my-project-master"
  }
}

resource "aws_instance" "my-project-worker-1" {
  ami                    = "ami-0e735aba742568824"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.my-project-public-subnet-2.id
  associate_public_ip_address = true  
  key_name               = "${aws_key_pair.project-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.my-project-public-sg.id}"]

  tags = {
    Name = "my-project-worker-1"
  }
}

resource "aws_instance" "my-project-worker-2" {
  ami                    = "ami-0e735aba742568824"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.my-project-public-subnet-1.id
  associate_public_ip_address = true
  key_name               = "${aws_key_pair.project-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.my-project-public-sg.id}"]

  tags = {
    Name = "my-project-worker-2"
  }
}