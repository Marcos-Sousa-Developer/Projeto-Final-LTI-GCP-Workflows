#!/bin/bash

#Database tolerance fault 
#{YOUR_IP_ADDRESS} example IP
    
if timeout 3s bash -c "</dev/tcp/{YOUR_IP_ADDRESS}/{YOUR_PORT}" &>/dev/null; then
    echo "other is running well"
    exit 0
else

    # Unassign peer's IP aliases. Try it until it's possible.
    if gcloud compute instances network-interfaces update database-instance-master --zone europe-southwest1-a --aliases "" --quiet > /dev/null 2>&1 & then
        echo "delete process done"  
        echo "delete alias from db-master" >> /etc/keepalived/takeover.log  
    fi

    sleep 3

    # Assign IP aliases to me because now I am the MASTER!
    if gcloud compute instances network-interfaces update database-instance-slave --zone europe-southwest1-a --aliases {YOUR_IP_ADDRESS} --quiet > /dev/null 2>&1 & then
        echo "add process done"  
        echo "add alias to slvae-db" >> /etc/keepalived/takeover.log  
    fi

    sleep 3

    echo "STOP SLAVE;" | sudo mysql -u root -p"rootGreaterGoods1234!" 

    sudo service mysql stop 

    sudo sed -i "s/^bind-address.*/bind-address = {YOUR_IP_ADDRESS}/" /etc/mysql/mysql.conf.d/mysqld.cnf

    sudo service mysql start

    sudo service mysql restart &

    echo "Im a new maste" >> /etc/keepalived/takeover.log
    
    exit 1
fi