resource "aws_elb" "galera" {
    name                = "${lookup(var.elb,"name")}"
    subnets             = [
        "${var.subnets}"
    ]

    internal        = "${lookup(var.elb,"internal")}"
    security_groups = "${var.sgs}"

    listener {
        instance_port       = "${lookup(var.elb,"instance_port")}"
        instance_protocol   = "${lookup(var.elb,"instance_protocol")}"

        # The below loopups will be swithced to list variables in
        # the future to ensure maximum re-usability of code.
        lb_port             = "${lookup(var.elb,"lb_port")}"
        lb_protocol         = "${lookup(var.elb,"lb_protocol")}"
    }
    cross_zone_load_balancing = "${lookup(var.elb,"cross_zone_lb")}"
}

resource "aws_route53_record" "galera" {
    zone_id = "${var.route53}"
    name    = "${lookup(var.elb,"endpoint")}"
    type    = "A"

    alias {
        name                   = "${aws_elb.galera.dns_name}"
        zone_id                = "${aws_elb.galera.zone_id}"
        evaluate_target_health = true
    }
}
