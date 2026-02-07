variable "env"{
  default="dev"
}
variable "component" {
  default = "frontend"
}
variable "ami" {
  default = "ami-0220d79f3f480ecf5"
}
variable "sg" {
  default = "sg-00200ecf86b9b6868"
}
variable "subnet_id" {
  default = "subnet-0e4eadfc446b55f58"
}
variable "vpc_id" {
  default = "vpc-02a94ee8944923438"
}