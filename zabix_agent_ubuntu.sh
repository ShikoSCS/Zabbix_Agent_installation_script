#!/bin/bash

# Download and install the Zabbix repository
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb &&
dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb &&

# Update package lists
apt update &&

# Install the Zabbix agent
apt install -y zabbix-agent &&

# Configure the Zabbix agent
sed -i 's/^\s*Server=127.0.0.1/Server=SERVERIP/' /etc/zabbix/zabbix_agentd.conf &&
sed -i 's/^\s*ServerActive=127.0.0.1/ServerActive=SERVERIP/' /etc/zabbix/zabbix_agentd.conf &&

# Start the Zabbix agent and enable it to start at system boot
systemctl restart zabbix-agent &&
systemctl enable zabbix-agent
