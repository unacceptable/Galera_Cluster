resource "aws_elb" "MariaDB" {
    name                = "MariaDB-ELB"
    subnets             = [
        "${var.subnets}"
    ]

    listener {
        instance_port       = 3306
        instance_protocol   = "tcp"
        lb_port             = 3306
        lb_protocol         = "tcp"
    }
    cross_zone_load_balancing = true
}
