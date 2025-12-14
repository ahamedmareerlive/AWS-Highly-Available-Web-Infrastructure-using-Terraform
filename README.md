# AWS Highly Available Web Infrastructure using Terraform

This project provisions a highly available, scalable web infrastructure on AWS using Terraform with a modular architecture.

The infrastructure is designed following AWS best practices and includes a custom VPC, public and private subnets across multiple Availability Zones, NAT Gateway, Auto Scaling Group, and an Application Load Balancer.

## 🏗 Architecture Overview



* **VPC:** CIDR `10.0.0.0/16`
* **Availability Zones:** 2 Zones in `us-east-1`
* **Public Subnets:**
    * One public subnet per AZ
    * Internet Gateway for inbound internet traffic
* **Private Subnets:**
    * One private subnet per AZ
    * Instances have no direct internet access
* **Single NAT Gateway:** Allows private subnet instances to access the internet securely
* **Auto Scaling Group (ASG):**
    * EC2 instances launched only in private subnets
    * **Desired:** 2 | **Min:** 1 | **Max:** 4
    * Automatically scales based on load
* **Application Load Balancer (ALB):**
    * Listens on port `80`
    * Forwards traffic to EC2 instances on port `8000`
    * Automatically registers/deregisters instances created by ASG
* **Security Groups:**
    * **ALB:** Allows HTTP (`80`) from anywhere
    * **EC2:** Allows traffic from ALB on port `8000` and SSH (`22`)
* **Launch Template:**
    * AMI and instance type configurable
    * Supports SSH key pair

## 📁 Project Structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules
   ├── vpc
   │   ├── main.tf
   │   ├── variables.tf
   │   └── outputs.tf
   ├── asg
   │   ├── main.tf
   │   ├── variables.tf
   │   └── outputs.tf
   └── alb
       ├── main.tf
       ├── variables.tf
       └── outputs.tf
```
## 🔁 Modular Design

This project uses Terraform modules to keep the infrastructure reusable, maintainable, and easy to extend.

* **VPC Module:** Creates VPC, subnets, route tables, IGW, NAT Gateway
* **ASG Module:** Launch Template, Security Group, Auto Scaling Group
* **ALB Module:** Application Load Balancer, Target Group, Listener, ASG attachment

## ⚙️ Configuration

All configurable values are provided via `terraform.tfvars`, making the project environment-agnostic and easy to reuse. Configuration includes:

* VPC CIDR
* Subnet CIDRs and names
* AMI ID
* Instance type
* Auto Scaling capacity
* Allowed ports
* ALB and ASG names

## 🚀 How to Deploy

1.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

2.  **Review the infrastructure plan:**
    ```bash
    terraform plan
    ```

3.  **Apply the configuration to deploy resources:**
    ```bash
    terraform apply
    ```

> **Note:** After deployment, the ALB DNS name is printed as an output and can be used to access the application.

## 📤 Outputs

The Terraform run will provide the following outputs:

* VPC ID
* Public & Private Subnet IDs
* Auto Scaling Group Name
* Application Load Balancer DNS Name

## 🔐 Security Best Practices

* **Private Isolation:** EC2 instances run only in private subnets.
* **Traffic Flow:** Internet traffic is handled strictly via the ALB.
* **Secure Outbound:** Outbound internet access is managed via NAT Gateway.
* **Least Privilege:** Security groups follow the least privilege principle.

## 🧠 Key Learnings

* Terraform module design and variable passing
* AWS networking fundamentals (VPC, subnets, routing)
* Auto Scaling with Load Balancers
* Secure architecture using private subnets
* Real-world infrastructure provisioning

## 📌 Technologies Used

* Terraform
* AWS (VPC, EC2, ASG, ALB, NAT Gateway, IAM)
* Infrastructure as Code (IaC)
