terraform {
  backend "s3" {
    bucket  = "eks-mumbai-bucket"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    #profile = "sarthak.agarwal@8526-6464-5470"
  }
}