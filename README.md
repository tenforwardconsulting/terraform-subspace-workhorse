# Subspace / Workhorse

This terraform module creates a single server designed to host an entire application all in one place.  Often this is used for development/dev environments or very lightweight applications. It does not provision any storage other than local / EBS storage (e.g. no RDS, no S3, etc) but you can certainly add that.

It does create networking resources including a (public) VPC and an Elastic IP address for the server.

# Example Usage

    provider "aws" {
      region                   = "us-east-1"
      profile                  = "subspace-my-project"
    }

    module workhorse {
      source = "github.com/tenforwardconsulting/terraform-subspace-workhorse"
      project_name = "my-project"
      project_environment = "dev"
      aws_region = "us-east-1"
      subspace_public_key = file("../../subspace.pem.pub")
      subdomain = "myproject"
      zone_id = "" # AWS zone id if you want to autocreate DNS

      # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
      instance_ami = "ami-039af3bfc52681cd5"
      instance_user = "ubuntu"
      instance_type = "t3.medium"
      instance_hostname = "dev-app1"
      instance_volume_size = 16

      ssh_cidr_blocks = ["0.0.0.0/0"]
    }

## Input Variables

See [variables.tf] for details.

## Outputs

See [outputs.tf] for details.

## Route 53 DNS

This will *always* create a Route53 zone, but it is up to you to ensure that the zone is referenced at the registrar.  The nameservers are included in the outputs.  If you don't actually use it, it can still be useful for tracking the IPs internally.

Since multiple environments will usually share the same Route53 Zone, you often need to import any existing zone, which you can do as follow:

  terraform import module.workhorse.aws_route53_zone.primary Z01235183LTADNNF1ZD2D
