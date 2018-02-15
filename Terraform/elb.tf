resource "aws_elb" "DB_Cluster" {
    name                = "DBCluster-ELB"
    subnets             = [
        "${var.subnets}"
    ]

    internal        = true
    security_groups = "${var.sgs}"

    listener {
        instance_port       = 3306
        instance_protocol   = "tcp"
        lb_port             = 3306
        lb_protocol         = "tcp"
    }
    cross_zone_load_balancing = true
}

resource "aws_route53_record" "galera" {
    zone_id = "${var.route53}"
    name    = "galera.scriptmyjob.com"
    type    = "A"

    alias {
        name                   = "${aws_elb.DB_Cluster.dns_name}"
        zone_id                = "${aws_elb.DB_Cluster.zone_id}"
        evaluate_target_health = true
    }
}
