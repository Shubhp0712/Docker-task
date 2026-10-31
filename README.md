### Run the docker compose file
```
docker compose up
```
### Run this commands before runnig script
- First command loads br_netfilter kernel module
- **What this command does** : When you load br_netfilter, it forces packets traversing a Linux network bridge to be processed by the Netfilter (iptables) firewall.
```
sudo modprobe br_netfilter
```
- Use this command to check the, **net.bridge.bridge-nf-call-iptables** This kernel parameter value it must be set to 1.
```
sysctl net.bridge.bridge-nf-call-iptables
```
### Run the script file for apply firewall rules
```
chmod 755 script.sh
./script.sh
```
