resource "null_resource" "ansible_exec" {
    depends_on =[
        "aws_autoscaling_group.DB_Cluster"
    ]

    provisioner "local-exec" {
        command     = " "
        interpreter = ["/bin/bash", "./local-exec-ansible.sh"]
    }
}
