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

### 1. Provision the infrastructure

```bash
cd terraform
terraform init
terraform apply
```

### 2. Grab the EC2 public IP

```bash
terraform output -raw public_ip
```

### 3. Configure with Ansible

Prior to running Ansible, ensure to set the following:

```bash
export TF_PUBLIC_IP=$(terraform output -raw public_ip)
export TF_PEM_PATH=!/.ssh/tf-lab-key.pem
```

Following this, in the ansible directory:

```bash
cd ../ansible  
ansible-playbook playbooks/site.yml 
```

### 4. Test in browser

```

http://<PUBLIC_IP>
```

### 5. Ensure resources are destroyed after use 

```bash
terraform destroy
```

