# Global (e.g. include -var-file=../global.vars)

variable aws_region { type = string }
variable project_name { type = string }
variable project_environment { type = string }
variable zone_id { type = string }
variable subdomain { type = string }
variable subspace_public_key { type = string }

# single_ec2.tf
variable instance_type { type = string }
variable instance_ami  { type = string }
variable instance_user { type = string }
variable instance_volume_size { type = number }

variable ssh_cidr_blocks {
  default = ["0.0.0.0/0"]
}

variable instance_hostname {
  type = string
}
