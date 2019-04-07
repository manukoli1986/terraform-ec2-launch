#!/bin/bash
sudo yum install git -y
sudo  amazon-linux-extras install ansible2 -y
sudo git clone https://github.com/manukoli1986/tomcat-webapp-stack.git /tmp/tomcat-webapp-deploy-stack
sudo rm -rf /etc/ansible/* && sudo mv /tmp/tomcat-webapp-deploy-stack/* /etc/ansible/ 
sudo ansible-playbook /etc/ansible/site.yml  --connection=local &> ansible-output.log
