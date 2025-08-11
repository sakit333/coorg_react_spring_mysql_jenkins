#!/bin/bash
# Common Ubuntu 24.04 Server Setup Script
# Maintained by: DevOps Engineer @sak_shetty
# Purpose: Update server, install Java 17, Jenkins, and essential tools.

LOG_FILE="/var/log/server_setup.log"

# Ensure log file exists
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE

echo "==============================================" | tee -a $LOG_FILE
echo "🛠 Common Ubuntu 24.04 Server Setup Script" | tee -a $LOG_FILE
echo "👨‍💻 Maintained by: DevOps Engineer @sak_shetty" | tee -a $LOG_FILE
echo "🎯 Purpose: Update server, install Java 17, Jenkins, and common tools" | tee -a $LOG_FILE
echo "==============================================" | tee -a $LOG_FILE

echo "🔹 Updating system packages..." | tee -a $LOG_FILE
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y | tee -a $LOG_FILE
echo "✅ Server update complete." | tee -a $LOG_FILE

# Install Java 17 if missing
if java -version 2>&1 | grep "17" >/dev/null; then
    echo "✅ Java 17 already installed." | tee -a $LOG_FILE
    java -version 2>&1 | tee -a $LOG_FILE
else
    echo "🔹 Installing Java 17..." | tee -a $LOG_FILE
    sudo apt install -y openjdk-17-jdk | tee -a $LOG_FILE
    echo "✅ Java 17 installation complete." | tee -a $LOG_FILE
    java -version 2>&1 | tee -a $LOG_FILE
fi

# Install Jenkins if missing
if systemctl list-units --type=service | grep jenkins >/dev/null; then
    echo "✅ Jenkins already installed." | tee -a $LOG_FILE
    systemctl status jenkins --no-pager | tee -a $LOG_FILE
else
    echo "🔹 Installing Jenkins..." | tee -a $LOG_FILE
    sudo apt install -y wget gnupg | tee -a $LOG_FILE
    sudo mkdir -p /etc/apt/keyrings
    sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update | tee -a $LOG_FILE
    sudo apt-get install -y jenkins | tee -a $LOG_FILE
    sudo systemctl enable jenkins | tee -a $LOG_FILE
    sudo systemctl start jenkins | tee -a $LOG_FILE
    echo "✅ Jenkins installation complete." | tee -a $LOG_FILE
fi

# Install common tools
echo "🔹 Installing essential tools..." | tee -a $LOG_FILE
sudo apt install -y curl wget unzip git | tee -a $LOG_FILE
echo "✅ Essential tools installed." | tee -a $LOG_FILE

# Add Jenkins user to visudo for passwordless sudo
echo "🔹 Adding 'jenkins' user to visudo for passwordless sudo..." | tee -a $LOG_FILE
if sudo grep -q "^jenkins" /etc/sudoers; then
    echo "✅ Jenkins already has sudo privileges." | tee -a $LOG_FILE
else
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
    echo "✅ Jenkins sudo privileges added." | tee -a $LOG_FILE
fi

echo "🎯 Server preparation completed successfully." | tee -a $LOG_FILE
