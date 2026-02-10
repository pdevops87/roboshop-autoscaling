db_components = {
    mongodb = {
      ports = { ssh = 22, app = 27017 }
      instance_type = "t2.micro"
    }
  }

env= "dev"
ami = "ami-0220d79f3f480ecf5"
subnet_id = ["subnet-0e4eadfc446b55f58"]
vpc_id="vpc-02a94ee8944923438"



