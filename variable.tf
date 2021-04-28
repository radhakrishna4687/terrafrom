
/*
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_cidrs" {
    type = "list" 
    # terrafrom dtata type is here is list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_cidrs" {
    type = "list"
    default = ["10.0.3.0/24", "10.0.4.0/24"]

}
*/

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_cidrs" {
  type = list
  rds_subnet_1 = ["10.0.1.0/24", "10.0.2.0/24"]
}

/*
variable "private_cidrs" {
  type = "list"
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

*/