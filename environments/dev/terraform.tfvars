vpc_name = "eks-renter-dev"

vpc_cidr = "10.20.0.0/16"

public_subnets = {
  public_a = {
    cidr = "10.20.0.0/20"
    az   = "ap-south-1a"
  }

  public_b = {
    cidr = "10.20.16.0/20"
    az   = "ap-south-1b"
  }

  public_c = {
    cidr = "10.20.32.0/20"
    az   = "ap-south-1c"
  }
}

private_subnets = {
  private_a = {
    cidr = "10.20.48.0/20"
    az   = "ap-south-1a"
  }

  private_b = {
    cidr = "10.20.64.0/20"
    az   = "ap-south-1b"
  }

  private_c = {
    cidr = "10.20.80.0/20"
    az   = "ap-south-1c"
  }
}

cluster_name                = "renter-dev"
cluster_version             = "1.36"
node_desired_size           = 2
node_min_size               = 1
node_max_size               = 3
node_instance_types         = ["c7i-flex.large"]
cluster_admin_principal_arn = "arn:aws:iam::264595824735:user/saurav"

eks_addons = {
  vpc-cni = {
    addon_version = "v1.22.4-eksbuild.3"
  }

  coredns = {
    addon_version = "v1.14.3-eksbuild.3"
  }

  kube-proxy = {
    addon_version = "v1.36.0-eksbuild.14"
  }

  eks-pod-identity-agent = {
    addon_version = "v1.3.10-eksbuild.3"
  }

  aws-ebs-csi-driver = {
    addon_version = "v1.63.1-eksbuild.1"
  }
}

ecr_repository_name = "renter"