########################################
### Variables ##########################
########################################

data "aws_availability_zones" "available" {}

variable "global" {
    type = "map"
    default = {
        environment = "Staging"
        region      = "us-west-2"
    }
}

variable "elb" {
    type = "map"
    default = {
        name                = "galera"
        endpoint            = "galera.scriptmyjob.com"
        internal            = true
        instance_port       = 3306
        instance_protocol   = "tcp"
        lb_port             = 3306
        lb_protocol         = "tcp"
        cross_zone_lb       = true
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
        lc_name     = "DB_Cluster"
        asg_name    = "DB_Cluster ASG"
        image       = "ami-0def3275"
        size        = "m3.medium"
        key_name    = "MariaDB"
        spot_price  = 0.067
        min_size    = 3
        max_size    = 3
        tag_name    = "DB_Cluster"
    }
}
