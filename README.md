# Terraform & Ansible EC2 nginx lab

This project provisions an Amazon Linux 2023 EC2 instance using Terraform,
then configures it via Ansible over SSH to install and run nginx with
a custom HTML page.

## Stack
- Terraform
- Ansible
- AWS EC2 (image being Amazon Linux 2023)
- nginx

## How this works
1. Terraform creates the following;
   - EC2
   - Security group (ports 22, 80)
   - Injects SSH key
2. Ansible:
   - SSH into instance
   - Installs nginx
   - Deploys index.html

## How to run

```bash
terraform init
terraform apply
ansible-playbook playbooks/site.yml 

