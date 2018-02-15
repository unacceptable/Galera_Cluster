resource "null_resource" "start_sleep" {
    depends_on = [
        "aws_autoscaling_group.DB_Cluster"
    ]

    provisioner "local-exec" {
        command = "sleep 10"
    }
}

resource "null_resource" "ansible_exec" {
    depends_on =[
        "null_resource.start_sleep"
    ]

    provisioner "local-exec" {
        command = "${file("local-exec-ansible.sh")}"
    }
}
