variable "env"{
  default="dev"
}

db_components = {
  mongodb = {
     ports = { ssh=22 , app= 27017 }
     instance_type = "t3.micro"
  }
  redis = {
    ports = { ssh=22 , app=6379 }
    instance_type = "t3.micro"
  }
  mysql = {
    ports = { ssh=22 , app=3306 }
    instance_type = "t3.micro"
  }
  rabbitmq = {
    ports = { ssh=22 , app=5672 }
    instance_type = "t3.micro"
  }
}
variable "db_components" {}
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