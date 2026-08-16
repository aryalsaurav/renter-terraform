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