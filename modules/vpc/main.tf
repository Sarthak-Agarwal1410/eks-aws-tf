resource "aws_vpc" "vpc_kubernetes" {
  cidr_block       = var.k8s_cidr_block
  enable_dns_hostnames = true
  instance_tenancy = "default"
  # provisioner "local-exec" {
  #   command = "pwd"
  # }

  tags = {
    Name = "${var.name}-vpc-kubernetes"
    project = "${var.name}"
    tier = "networking"
  }
}

resource "aws_subnet" "subnet_k8s_1a" {
  vpc_id     = aws_vpc.vpc_kubernetes.id
  map_public_ip_on_launch = true
  cidr_block = var.subnet_cidr_block_1a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.name}-subnet-k8s-1a"
    Environment = var.name
    project = "${var.name}"
    tier = "networking"
    "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1

  }
}

resource "aws_subnet" "subnet_k8s_1b" {
  vpc_id     = aws_vpc.vpc_kubernetes.id
  map_public_ip_on_launch = true
  cidr_block = var.subnet_cidr_block_1b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.name}-subnet-k8s-1b"
    Environment = var.name
    project = "${var.name}"
    tier = "networking"
    "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "subnet_k8s_1c" {
  vpc_id     = aws_vpc.vpc_kubernetes.id
  map_public_ip_on_launch = true
  cidr_block = var.subnet_cidr_block_1c
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "${var.name}-subnet-k8s-1c"
    Environment = var.name
    project = "${var.name}"
    tier = "networking"
    "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_internet_gateway" "internet_gateway_k8s" {
  vpc_id = aws_vpc.vpc_kubernetes.id

  tags = {
    Name = "${var.name}-k8s-igw"
    "Environment" = var.name
     project = "${var.name}"
     tier = "networking"

  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id =  aws_vpc.vpc_kubernetes.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_k8s.id
  }


  tags = {
    Name = "${var.name}-Public-RouteTable"
    "Environment" = var.name
    project = "${var.name}"
    tier = "networking"
  }
}

resource "aws_route_table_association" "route_table_association_public" {
  count = length(var.k8s_subnets)
  subnet_id      = element(var.k8s_subnets, count.index)
  route_table_id = aws_route_table.route_table_public.id
}
