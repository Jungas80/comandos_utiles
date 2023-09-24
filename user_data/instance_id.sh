#!/bin/bash

# Update the package lists and install httpd (Apache web server)
yum update -y
yum install -y httpd

# Enable and start the httpd service
systemctl enable httpd
systemctl start httpd

# Fetch instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Fetch public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Create a styled HTML message
HTML_CONTENT="<html>
<head>
  <title>AWS EC2 Instance Info</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      text-align: center;
      margin-top: 50px;
    }
    .container {
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      display: inline-block;
    }
    h1 {
      color: #333;
    }
    p {
      font-size: 18px;
    }
  </style>
</head>
<body>
  <div class='container'>
    <h1>Hello from AWS!</h1>
    <p>Instance ID: $INSTANCE_ID</p>
    <p>Public IP: $PUBLIC_IP</p>
  </div>
</body>
</html>"

# Write the HTML content to index.html
echo "$HTML_CONTENT" > /var/www/html/index.html