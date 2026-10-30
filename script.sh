#!/bin/bash
Container1=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_1)
Container2=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_2)
Container3=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_3)

echo "C1=$Container1"
echo "C2=$Container2"
echo "C3=$Container3"

sudo iptables -N DOCKER-TASK 2>/dev/null || true

sudo iptables -F DOCKER-TASK

while sudo iptables -C DOCKER-USER -j DOCKER-TASK 2>/dev/null; do
    sudo iptables -D DOCKER-USER -j DOCKER-TASK
done

sudo iptables -A DOCKER-TASK \
  -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

sudo iptables -A DOCKER-TASK -s "$Container1" -d "$Container3" -j DROP

sudo iptables -A DOCKER-TASK -s "$Container2" -d "$Container1" -j DROP

sudo iptables -A DOCKER-TASK -s "$Container3" -d "$Container2" -j DROP


sudo iptables -A DOCKER-TASK -j RETURN

sudo iptables -A DOCKER-USER -j DOCKER-TASK