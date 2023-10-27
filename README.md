# Three Tier Architecture for a Web Application
https://www.joe-edwards.co.uk/#portfolio/portfolio-1

To design and implement a robust infrastructure on AWS to host a web application that prioritizes high availability, fault tolerance, and security. In addition, the project must leverage Infrastructure as Code (IaC) principles to ensure efficient management, scalability, and ease of maintenance.

Backend Configuration:
We utilized a remote backend to store Terraform state, enabling collaboration, centralized state management, secure storage, backup, and versioning. This enhances the reliability and manageability of the infrastructure.

Network:
We established a Virtual Private Cloud (VPC) with public and private subnets, ensuring secure traffic routing and network segmentation. This design allows for controlled internet access and private communication.

Load Balancer:
An Application Load Balancer (ALB) was configured to distribute incoming traffic to a target group, enhancing scalability and availability. Health checks and routing rules were defined to maintain the health of instances.

Auto Scaling:
An Auto Scaling group was set up to dynamically adjust the number of EC2 instances based on CPU utilization. This ensures optimal resource allocation and cost efficiency.

Launch Template:
We defined a launch template that specifies the configuration of EC2 instances, including the Amazon Machine Image (AMI), instance type, user data, and IAM instance profile. This template ensures consistency in instance configuration.

IAM:
IAM roles and instance profiles were created to enable Session Manager for secure instance access. This eliminates the need for direct SSH access and simplifies security management.

Database:
We provisioned an Amazon RDS MySQL database in a multi-availability zone configuration to ensure high availability and data redundancy. Security was enhanced by securely managing the master user password using AWS Secrets Manager.

Security Groups:
Security groups were configured for the ALB, EC2 instances, and RDS instances to control incoming and outgoing traffic, ensuring a secure and controlled network environment.

Outputs: An output was defined to display the DNS name of the ALB, making it convenient for testing the infrastructure's functionality.
