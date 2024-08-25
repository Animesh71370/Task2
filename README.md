Security Audit and Server Hardening Script
Overview
This Bash script automates the process of performing security audits and applying hardening measures on Linux servers. The script is modular, reusable, and configurable, allowing it to be easily deployed across multiple environments. It includes checks for common security vulnerabilities, ensures proper configurations for IPv4/IPv6, and implements essential hardening steps to protect your server.

Features
User and Group Audits:

Lists all users and groups.
Checks for users with UID 0 (root privileges) and reports non-standard users.
Identifies and reports users without passwords or with weak passwords.
File and Directory Permissions:

Scans for files and directories with world-writable permissions.
Checks for .ssh directories and ensures they have secure permissions.
Reports files with SUID or SGID bits set, particularly on executables.
Service Audits:

Lists all running services and checks for unnecessary or unauthorized services.
Ensures critical services like sshd and iptables are running and properly configured.
Checks for services listening on non-standard or insecure ports.
Firewall and Network Security:

Verifies that a firewall (iptables, ufw) is active and configured to block unauthorized access.
Reports open ports and their associated services.
Checks for insecure network configurations, such as IP forwarding.
IP and Network Configuration Checks:

Identifies whether the server's IP addresses are public or private.
Provides a summary of all IP addresses assigned to the server.
Ensures sensitive services (e.g., SSH) are not exposed on public IPs unless required.
Security Updates and Patching:

Checks for and reports any available security updates or patches.
Ensures the server is configured to receive and install security updates regularly.
Custom Security Checks:

Allows easy extension with custom security checks through a configuration file (security_checks.conf).
Reporting and Alerting:

Generates a summary report of the security audit and hardening process.
Optionally, sends email alerts if critical vulnerabilities or misconfigurations are found.
Prerequisites
Bash shell (Linux environment)
Root or sudo access to execute commands