# This script is for Amazon Linux 2

# Update VM
sudo yum update -y

# Install Docker
sudo yum install docker -y
# Assuming default user is "ec2-user"
sudo usermod -aG docker ec2-user 
id ec2-user
newgrp docker

# Start Docker service
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Verifying Docker service is running
docker info

# Clone Docker socket
git clone https://github.com/wardviaene/jenkins-docker.git
# Change GID from 999 to Docker group on your system. Can check via "getent group docker" command.
docker build -t jenkins-docker .

# Start Jenkins container on Docker
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -d --name jenkins jenkins-docker