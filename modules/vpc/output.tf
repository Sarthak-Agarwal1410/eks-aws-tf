output "kubernetes_vpc_id" {
  value = aws_vpc.vpc_kubernetes.id
}

output "kubernetes_vpc_id_cidr" {
  value = aws_vpc.vpc_kubernetes.cidr_block
}

output "k8s_subnet_ids" {
  value = [aws_subnet.subnet_k8s_1a.id, aws_subnet.subnet_k8s_1b.id, aws_subnet.subnet_k8s_1c.id]
}