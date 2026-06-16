# ---------- AMI DATA SOURCE ----------
data "aws_ami" "ubuntu_2604" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's Official AWS Account ID

  filter {
    name   = "name"
    # Matches the exact standard image pattern for Resolute Raccoon (amd64)
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Matches amd64 
  }

}

#------------ IAM ROLE ------------ 

resource "aws_iam_role" "iam_role" {
  name = var.iam_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#------------ IAM POLICY ------------ 

resource "aws_iam_policy" "iam_policy" {
  name = var.iam_policy

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = var.secret_arn
      }
    ]
  })
}

#------------ ATTACH POLICY ------------ 

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}


#------------ INSTANCE PROFILE ------------ 


resource "aws_iam_instance_profile" "instance_profile" {
  name = var.instance_profile
  role = aws_iam_role.iam_role.name
}


# ---------- EC2 INSTANCE ----------
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ubuntu_2604.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.ec2_key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    curl -sfL https://get.k3s.io | sh -
    
    while [ ! -f /etc/rancher/k3s/k3s.yaml ]; do
      sleep 3
    done

    mkdir -p /home/ubuntu/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
    sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
    echo 'export KUBECONFIG=/home/ubuntu/.kube/config' >> /home/ubuntu/.bashrc
    export KUBECONFIG=/home/ubuntu/.kube/config
    
    ########################################
    # Install Helm
    ########################################

    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    ########################################
    # Install CSI Driver
    ########################################

    helm repo add secrets-store-csi-driver \
      https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts

    ########################################
    # Install AWS Provider
    ########################################

    helm repo add aws-secrets-manager \
      https://aws.github.io/secrets-store-csi-driver-provider-aws

    helm repo update

    helm upgrade --install csi-secrets-store \
      secrets-store-csi-driver/secrets-store-csi-driver \
      --namespace kube-system \
      --create-namespace \
      --wait \
      --timeout 5m

    helm upgrade --install secrets-provider-aws \
      aws-secrets-manager/secrets-store-csi-driver-provider-aws \
      --namespace kube-system \
      --wait \
      --timeout 5m

    EOF

  tags = {
    Name        = var.ec2_name
    Environment = var.environment
  }
}

