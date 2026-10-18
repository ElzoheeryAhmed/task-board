resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "bastion_key" {
  content         = tls_private_key.bastion.private_key_pem
  filename        = "${path.root}/${var.name}-bastion-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "bastion" {
  key_name   = "${var.name}-bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
}

resource "aws_instance" "bastion" {
  ami                    = "ami-00adafae70b8029d8"
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.bastion.key_name # Optional if using SSM exclusively

  # Enforce IMDSv2
  metadata_options {
    http_tokens                 = "required"
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  domain   = "vpc"

  tags = {
    Name = "bastion-eip"
  }
}

resource "time_sleep" "wait_for_ssh" {
  create_duration = "45s"
  depends_on      = [aws_eip.bastion_eip]
}


resource "null_resource" "bastion_setup" {
  depends_on = [time_sleep.wait_for_ssh]

  triggers = { instance_id = aws_instance.bastion.id } #recreation of null resource after id change

  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.bastion.private_key_pem
  }

  provisioner "remote-exec" {
    inline = ["sudo dnf install -y jq"]
  }

  provisioner "local-exec" {
    command = "echo ${aws_eip.bastion_eip.public_ip} > ${path.root}/${var.name}-bastion-ip.txt"
  }
}