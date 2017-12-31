########################################
### Variables ##########################
########################################

data "aws_availability_zones" "available" {}

variable "global" {
    type = "map"
    default = {
        environment = "td"
        region      = "us-west-2"
    }
}

variable "vpc" {
    type = "map"
    default = {
        var         = true
    }
}

variable "ec2" {
    type = "map"
    default = {
        lc_name     = "MariaDB"
        asg_name    = "MariaDB ASG"
        image       = "ami-0def3275"
        size        = "m3.medium"
        key_name    = "MariaDB"
        spot_price  = 0.067
        min_size    = 3
        max_size    = 3
        tag_name    = "MariaDB"
    }
}
