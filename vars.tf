variable "myaccesskey" {
  description = "your AWS IAM access key"
  type        = string
  sensitive   = true
}
variable "mysecretkey" {
  description = "your AWS IAM secret access key"
  type        = string
  sensitive   = true
}
variable "myregion" {
  description = "your required AWS region"
  type        = string
}
variable "mycidr" {
  description = "CIDR for VPC you are planning"
  type        = string
}
variable "mycidrsub1" {
  description = "CIDR for Subnet of VPC you are planning"
  type        = string
}

