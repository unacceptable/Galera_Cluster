resource "aws_launch_configuration" "DB_Cluster" {
    name                            = "${lookup(var.ec2, "lc_name")}"
    image_id                        = "${lookup(var.ec2, "image")}"
    instance_type                   = "${lookup(var.ec2, "size")}"
    key_name                        = "${lookup(var.ec2, "key_name")}"
    security_groups                 = [
        "${var.sgs}"
    ]
    associate_public_ip_address     = true
    user_data                       = "${file("bootstrap.sh")}"
    spot_price                      = "${lookup(var.ec2, "spot_price")}"
}

resource "aws_autoscaling_group" "DB_Cluster" {
    depends_on                      = [
        "aws_launch_configuration.DB_Cluster"
    ]

    availability_zones              = [
        "${data.aws_availability_zones.available.names}"
    ]

    name                            = "${lookup(var.ec2, "asg_name")}"
    max_size                        = "${lookup(var.ec2, "max_size")}"
    min_size                        = "${lookup(var.ec2, "min_size")}"
    launch_configuration            = "${lookup(var.ec2, "lc_name")}"

    vpc_zone_identifier             = [
        "${var.subnets}"
    ]

    tags    = [
        {
            key                     = "Name"
            value                   = "${lookup(var.ec2, "tag_name")}"
            propagate_at_launch     = true
        },
        {
            key                     = "Environment"
            value                   = "${lookup(var.global, "environment")}"
            propagate_at_launch     = true
        }
    ]

    load_balancers                  = [
        "${lookup(var.elb,"name")}"
    ]
}
