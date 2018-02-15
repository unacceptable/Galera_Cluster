resource "null_resource" "start_sleep" {
    depends_on = [
        "aws_autoscaling_group.DB_Cluster"
    ]

    provisioner "local-exec" {
        command = "sleep 10"
    }
}

data "aws_instances" "DB_Cluster" {
    depends_on = [
        "null_resource.start_sleep"
    ]

    filter {
        name    = "tag:Name"
        values  = [
            "DB_Cluster"
        ]
    }
}

resource "null_resource" "ansible_exec" {
    provisioner "local-exec" {
        command =<<SCRIPT
    cd ../Ansible;
    until nmap -p 22 ${data.aws_instances.DB_Cluster.public_ips[0]} -Pn; do
        sleep 2;
    done &&
        sleep 10; # give python a few seconds to install
    ansible-playbook database.yml;
SCRIPT
    }
}
