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
        command     = "echo 'This command doesn't matter but I must put it in for some reason'"
        interpreter = ["/bin/bash", "./local-exec-ansible.sh"]
    }
}
