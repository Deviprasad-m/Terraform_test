terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
    }
  }
}
provider "aws" {
  access_key = var.myaccesskey
  secret_key = var.mysecretkey
  region     = var.myregion
}
resource "aws_vpc" "myvpc1" {
  cidr_block       = var.mycidr
  instance_tenancy = "default"
  tags = {
    Name = "Deva-main-vpc1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.mycidrsub1
  tags = {
    Name = "Deva-main-vpc-subnet2"
  }
}

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc1.id
  tags = {
    Name = "Deva_main_IG"
  }
}
resource "aws_route_table" "myroute1" {
  vpc_id = aws_vpc.myvpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }
  tags = {
    Name = "Deva-routetable"
  }
}
resource "aws_route_table_association" "myroute1_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.myroute1.id
}
resource "aws_security_group" "mysg" {
  name   = "allow_ssh_http"
  vpc_id = aws_vpc.myvpc1.id
  tags = {
    Name = "Deva_allow_ssh_https"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.mysg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.mysg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_ingress_rule" "allow_rdp_ipv4" {
  security_group_id = aws_security_group.mysg.id
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.mysg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
/*
resource "aws_instance" "myvm2" {
  ami= "ami-0d825a124481985ae"
  instance_type= "t2.micro"
  key_name= "Deva_KeyPair"
  subnet_id= aws_subnet.subnet2.id
  associate_public_ip_address= true
  vpc_security_group_ids= [aws_security_group.mysg.id]
  root_block_device {
    volume_type = "gp3"
   }
  tags= {
    Name= "DevaServer2"
   }
}

resource "aws_instance" "myvm3" {
  ami= "ami-0a422d70f727fe93e"
  instance_type= "t2.micro"
  key_name= "Deva_KeyPair"
  subnet_id= aws_subnet.subnet2.id
  associate_public_ip_address= true
  vpc_security_group_ids= [aws_security_group.mysg.id]
  root_block_device {
    volume_type = "gp2"
   }
user_data=<<-EOF
#!/bin/bash
sudo apt update
sudo apt install apache2 -y
echo"Hello from Deva" > /var/www/html/index.html
sudo sydtemctl start apache2
sudo systemctl enable apache2
EOF

  tags= {
    Name= "DevaServer3"
   }
}
resource "aws_instance" "myvm4" {
  ami= "ami-0d825a124481985ae"
  instance_type= "t2.micro"
  key_name= "Deva_KeyPair"
  subnet_id= aws_subnet.subnet2.id
  associate_public_ip_address= true
  vpc_security_group_ids= [aws_security_group.mysg.id]
  root_block_device {
    volume_type = "gp3"
   }
user_data=<<-EOF
<powershell>
Install-WindowsFeauture -name Web-Server-IncludeManagementTools
</powershell>
EOF

  tags= {
    Name= "DevaServer-iis"
   }
}
*/
resource "aws_instance" "myvm3" {
  ami= "ami-0a422d70f727fe93e"
  instance_type= "t2.micro"
  key_name= "Deva_KeyPair"
  subnet_id= aws_subnet.subnet2.id
  associate_public_ip_address= true
  vpc_security_group_ids= [aws_security_group.mysg.id]
  root_block_device {
    volume_type = "gp2"
   }
user_data=<<-EOF
#!/bin/bash
sudo apt update
sudo apt install apache2 -y
echo"Hello from Deva" > /var/www/html/index.html
sudo sydtemctl start apache2
sudo systemctl enable apache2
EOF

  tags= {
    Name= "DevaServer3"
   }
}


