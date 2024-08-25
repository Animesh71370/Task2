#!/bin/bash

#User and Group Audits

       #List All Users and Groups
        echo "Listing all users and groups..."
        cut -d: -f1 /etc/passwd
        cut -d: -f1 /etc/group


        #Check for Users with UID 0
        echo "Checking for users with UID 0..."
        awk -F: '($3 == 0) {print $1}' /etc/passwd

        #Identify Users Without Passwords
        echo "Checking for users without passwords..."
        awk -F: '($2 == "" || $2 == "*") {print $1}' /etc/shadow


#File and Directory Permissions

        #Scan for World-Writable Files
        echo "Scanning for world-writable files..."
        find / -type f -perm -o+w -exec ls -l {} \;

        #Check .ssh Directory Permissions
        echo "Checking .ssh directory permissions..."
        find /home -name ".ssh" -exec chmod 700 {} \;
        find /root -name ".ssh" -exec chmod 700 {} \;

        #Report Files with SUID/SGID Bits
        echo "Scanning for files with SUID/SGID bits..."
        find / -perm /6000 -exec ls -l {} \;


#Service Audits

        #List All Running Services:
        echo "Listing all running services..."
        systemctl list-units --type=service --state=running
        
        #Check Critical Services:
        echo "Checking critical services..."
        systemctl is-active ssh
        systemctl is-active iptables
    
        #Check for Insecure Ports:
        echo "Checking for insecure ports..."
        netstat -tuln | grep -Ev '127.0.0.1|::1'


4. Firewall and Network Security

        #Verify Firewall Status:
        echo "Verifying firewall status..."
        ufw status || iptables -L

        #Report Open Ports:
        echo "Reporting open ports..."
        netstat -tuln

        #Check for IP Forwarding:
        echo "Checking for IP forwarding..."
        sysctl net.ipv4.ip_forward


5. IP and Network Configuration Checks

        #Public vs. Private IP Checks:
        echo "Checking IP configuration..."
        ip -o addr show | awk '/inet/ {print $2, $4}'


6. Security Updates and Patching

        #Check for Available Updates:
        echo "Checking for available updates..."
        sudo apt-get update && sudo apt-get -s upgrade

        #Configure Automatic Updates:
        echo "Configuring automatic updates..."
        sudo apt-get install unattended-upgrades
        sudo dpkg-reconfigure --priority=low unattended-upgrades


7. Log Monitoring

        #Check for Suspicious Log Entries:
        echo "Checking for suspicious log entries..."
        grep 'Failed password' /var/log/auth.log


8. Server Hardening Steps

        #SSH Configuration:
        echo "Hardening SSH configuration..."
        sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
        sudo systemctl restart ssh

        #Disabling IPv6:
        echo "Disabling IPv6..."
        sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
        sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

        #Securing the Bootloader:
        echo "Securing the bootloader..."
        sudo grub-set-password

        #Implementing Firewall Rules:
        echo "Implementing firewall rules..."
        sudo iptables -P INPUT DROP
        sudo iptables -A INPUT -i lo -j ACCEPT
        sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT


#Custom Security Checks
#!/bin/bash

# Script for automating security audits and server hardening

# Other audit functions go here...

# Custom Security Checks
echo "Running custom security checks..."

# Check if the configuration file exists
if [ -f security_checks.conf ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        # Skip empty lines and comments
        if [[ ! -z "$line" && ! "$line" =~ ^# ]]; then
            echo "Executing: $line"
            eval "$line"
        fi
    done < security_checks.conf
else
    echo "Configuration file security_checks.conf not found!"
fi


#Reporting and Alerting

        #Generate a Summary Report:
        echo "Generating report..."
        echo "Security Audit Report" > audit_report.txt
        echo "=====================" >> audit_report.txt
        # Add relevant command outputs here






