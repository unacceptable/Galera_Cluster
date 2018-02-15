#!/usr/bin/env bash
# Written by:   Robert J.
#               Robert@scriptmyjob.com
set -e

# This script is called from Terraform via ansible.tf

main(){
    IP="$(get_ip)";
    check_host "$IP";
    exec_ansible;
}

get_ip(){
    JSON='[
        {
            "Name": "tag:Name",
            "Values": [
                "DB_Cluster"
            ]
        },
        {
            "Name": "instance-state-name",
            "Values": [
                "running"
            ]
        }
    ]'

    aws ec2 \
        describe-instances \
        --filter "$JSON" | \
            jq ".Reservations[0].Instances[0].PublicIpAddress" -r
}

check_host(){
    IP="$1"

    until
        nmap -p 22  "$IP" -Pn | grep -i ^host;
    do
        sleep 2;
    done &&
        sleep 10; # give python a few seconds to install
}

exec_ansible(){
    cd ../Ansible;
    ANSIBLE_FORCE_COLOR=true ansible-playbook database.yml;
}

main;
