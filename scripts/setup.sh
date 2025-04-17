#!/bin/bash
# Example system administration script

echo "===== System Information ====="
echo "Hostname: $(hostname)"
echo "IP Address: $(hostname -I)"
echo "Kernel: $(uname -r)"

echo -e "\n===== System Resources ====="
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo "Memory Usage:"
free -m | grep Mem | awk '{print $3"MB used out of "$2"MB total ("int($3/$2*100)"%)"}'
echo "Disk Usage:"
df -h / | tail -1 | awk '{print $5" used ("$3" out of "$2")"}'

echo -e "\n===== NGINX Status ====="
if pgrep -x "nginx" > /dev/null; then
    echo "NGINX is running"
    echo "Worker processes: $(ps aux | grep -c "[n]ginx: worker")"
else
    echo "NGINX is not running"
fi

echo -e "\n===== Listening Ports ====="
ss -tln
