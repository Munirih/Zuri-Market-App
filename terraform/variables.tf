variable "vpc_name" {
    description = "name of vpc"
    type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to launch the EC2 instance in"
  type        = string
}

variable "vpc_cidr" {
    description = "CIDR address for vpc"
    type        = string
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    description = "CIDR for public subnets"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "availability_zones" {
    description = "Availability Zones for subnets"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b"]
}

variable "environment" {
    description = "Enviroment tag (dev, staging, prod)"
    type        = string
    default     = "dev"
}

variable "aws_region" {
    description = "AWS region where resources will be created"
    type        = string
    default     = "us-east-1"
}

variable "ec2_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "ec2_key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
  default     = "my-aws-key"
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the EC2 instance in"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
  type        = string
}

variable "sg_name" {
    description = "The name of the security group"
    type        = string
}


variable "ingress_rules" {
    description = "A list of ingress rules to apply to the security group"
    type        = list(object({
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
}

variable "egress_rules" {
    description = "A list of egress rules to apply to the security group"
    type            = list(object({
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)   
    }))
}

variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
}

variable "api_secret_key" {
  description = "API key"
  type        = string
  sensitive   = true
}


variable "store_name" {
  description = "Store name"
  type        = string
}


variable "iam_role" {
  description = "IAM role name"
  type        = string
}

variable "iam_policy" {
  description = "IAM policy name"
  type        = string
}


variable "instance_profile" {
  description = "EC2 instance profile name"
  type        = string
}
