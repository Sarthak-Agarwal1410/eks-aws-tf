resource "aws_security_group" "security_group_eks" {
  name        = "${var.name}-eks-allow-all"
  description = "Allow all inbound traffic"
  vpc_id      = var.kubernetes_vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.k8s_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name}-sg"
    Environment = var.name
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.name}-eks-cluster"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids         = var.k8s_subnets
    security_group_ids = [aws_security_group.security_group_eks.id]
  }

  depends_on = [aws_security_group.security_group_eks]
}

resource "aws_eks_node_group" "eks_cluster_node_group" {
  count           = var.node_count
  cluster_name    = aws_eks_cluster.eks_cluster.id
  node_group_name = "${var.name}-${count.index}-eks-node"
  node_role_arn   = var.role_arn
  subnet_ids      = var.k8s_subnets
  disk_size       = lookup(var.disk_size, count.index)
  instance_types  = var.instancetype

  scaling_config {
    desired_size = var.scaledesired
    max_size     = var.scalemax
    min_size     = var.scalemin
  }

  remote_access {
    ec2_ssh_key = var.sshkey
  }

  depends_on = [aws_eks_cluster.eks_cluster]

  labels = {
    nodegroup = lookup(var.labels, count.index)
  }

  tags = {
    Name = "${var.name}-${count.index}-eks-node"
  }

  lifecycle {
    ignore_changes=[scaling_config]
  }
}

data "tls_certificate" "tls" {
  url        = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_openid_connect_provider" "open_id" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.tls.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  depends_on      = [data.tls_certificate.tls, aws_eks_cluster.eks_cluster]
}
