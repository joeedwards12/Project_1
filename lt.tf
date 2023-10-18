resource "aws_launch_template" "ec2_lt" {
  name_prefix            = "ec2_lt"
  image_id               = "ami-0bb4c991fa89d4b9b"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
yum -y install httpd
systemctl start httpd
systemctl enable httpd
echo '<html><h1>Hello From Your Web Server! Welcome!</h1></html>' > /var/www/html/index.html
 EOF
  )

  iam_instance_profile {
    name = aws_iam_instance_profile.example_ec2_instance_profile.name
  }
  lifecycle {
    create_before_destroy = true
  }
}
