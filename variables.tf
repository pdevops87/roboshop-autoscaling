variable "env"{
  default="dev"
}
variable "ami" {}
variable "sg" {
  default = "sg-00200ecf86b9b6868"
}
variable "subnet_id" {}
variable "vpc_id" {}

variable "db_components" {}
