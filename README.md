 - For Terraform Installation on Your Computer ---> https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

 - When Repo is cloned on your computer; Open your terminal, go to repo directory, apply the following command
 
    1- terraform init: Initialize Directory and downloads plugins of the provider.
    2- terraform plan: It creates the execution plan of our code. Check each resource to confirm the exact resource is what you intend to provision. If there are errors, read out the error as terraform makes it easy to debug.
    3- terraform apply: It creates the actual infrastructure

Verify the resources:

Terraform will create below resources

- VPC
- Application Load Balancer
- Public & Private Subnets
- EC2 instances
- RDS
- Route Table
- Internet Gateway
- NAT Gateway
- Security Groups
- Route Table


To design and implement the network infrastructure for the given
application, I would follow the steps below:
1. Create a Virtual Private Cloud (VPC):
• Create a VPC in AWS with a unique CIDR block (e.g.,
10.0.0.0/16).
2. Create subnets:
• Create two public subnets (e.g., 10.0.1.0/24 and
10.0.2.0/24) and two private subnets (e.g., 10.0.3.0/24
and 10.0.4.0/24).
• Distribute these subnets across two or more Availability
Zones (AZs) for high availability.
3. Configure security groups:
• Create a security group for the API server allowing
inbound traffic on HTTP/HTTPS ports (80/443) from the
internet and outbound traffic to the MySQL database.
• Create a security group for the MySQL database allowing
inbound traffic on the MySQL port (3306) only from the
API server security group and outbound traffic to the
internet.
4. Set up an Application Load Balancer (ALB):
• Create an ALB, attach it to the public subnets, and
configure it to route traffic to the Frontend Component
• Create a target group for the Frontend Component
and configure health checks.
5. Deploy the Backend application components:
•  Create and auto-scaling group, attach it to the private subnets, and configure it to route traffic to the Backend Component
• Launch the MySQL database in one of the private
subnets using AWS RDS, configured with Multi-AZ
deployment for high availability.
• Deploy the Frontend Component on EC2 instances or using
container orchestration services like AWS ECS or EKS,
distributed across multiple AZs for fault tolerance. Attach
the instances to the target group.
• Deploy the Backend Component on EC2 instances or using
container orchestration services like AWS ECS or EKS,
distributed across multiple AZs for fault tolerance. Attach
the instances to the auto-scaling group.
6. Configure a NAT Gateway:
• Launch a NAT Gateway in one of the public subnets and
configure a route table for private subnets to use the NAT
Gateway for internet access.
• This allows resources in private subnets to access the
internet (e.g., for updates or external dependencies) while
maintaining their private IP addresses and restricted
inbound access.

