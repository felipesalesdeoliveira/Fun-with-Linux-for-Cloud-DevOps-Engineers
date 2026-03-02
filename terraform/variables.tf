variable "aws_region" {
  default = "us-east-1"
}

variable "key_pair_name" {
  description = "Nome da sua EC2 Key Pair na AWS"
  type        = string
}
