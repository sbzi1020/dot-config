
### SSH
SSH is security Shell which allows you connecting to remove vm securely.
```bash
# 
sysrc sshd_enable=YES
service sshd restart # onestart: for this root only

cat /etc/rc.conf
# sshd_enable="YES"

# ssh USER_NAME@IP_Address
ssh lab@192.168.2.10
```
Copy resources between ssh client and ssh server:
```ssh
scp -rv fion@192.168.1.183:~/YourFile ~/YourLocalFile
```
Copy the ssh key to the target vm, so every time you ssh connect to the vm without password authentication which easy for you using `scp`
```bash
ssh-copy-id -i ~/.ssh/id_ed25519 lab@192.168.2.10
```

### Network connetting issue
1. checking the ip address
```bash
ifconfig # `ip add` for Linux, check the NIC's ip address and up/down

# ==============
# Set static IP
sysrc ifconfig_em0="inet 192.168.2.10 netmask 255.255.255.0"
sysrc defaultrouter="192.168.1.200"
# add DNS records to `/etc/resolv.conf`
nameserver 192.168.1.200
# restart netif and routing service
service netif restart && service routing restart
# ==============
# Set DHCP(dynamic ip)
sysrc ifconfig_em0="DHCP"
dhclient em0
service netif restart 
```
2. checking the network connectting
```bash
ping -c3 192.168.2.1 # try vm its own gateway
ping 192.168.1.200 # try our home router gateway
ping www.google.com
```
3. if the router gateway connection is ok, but the DNS nameserver can't be resolved.
```bash
# /etc/resolv.conf
nameserver 192.168.1.200
```
4. double check your firewall rules whether blocking
```bash
doas nvim /etc/pf.conf
# make sure your vm is added into the trust_vm_node list
# trust_vm_node = "{192.168.2.10,......}"

# after update, make sure reload it
doas pfctl -F all -f /etc/pf.conf

# checking the current rules
# `plist`
echo -en 'NAT Rules:\n' && doas pfctl -s nat && echo -en '\nFilter Rules:\n' && doas pfctl -s rules | rg ssh
```
5. Checking current routing table and adding a route to it:
```bash
netstat -rn4

route add default 192.168.2.1 # your switch or gateway

# write it into rc.conf, so it will be loaded first thing when booting
doas sysrc defaultrouter="192.168.2.1"
```

### PF (Package Filter / Firewall)
```bash
sysrc pf_enable="YES"

doas nvim /etc/pf.conf
# make sure your vm is added into the trust_vm_node list
# trust_vm_node = "{192.168.2.10,......}"

# after update, make sure reload it
doas pfctl -F all -f /etc/pf.conf

# checking the current rules
# `plist`
echo -en 'NAT Rules:\n' && doas pfctl -s nat && echo -en '\nFilter Rules:\n' && doas pfctl -s rules | rg ssh
```
Edit `/etc/pf.conf`: FreeBSD `pf` priority is bottom up (that's why `block all` initial. But the rules are reading from top down, when it meet `quick`, it will be applied first.
```bash
set block-policy drop
set skip on lo0

nic_wlan = "wlan0"
nic_group = "wlan"
nic_vm_switch = "vm-internal"
nic_vm_group = "vm-switch"
trust_vm_node = "{192.168.2.10, 192.168.2.20}"
# ==============================
# vm related
# ==============================
nat on $nic_wlan from $nic_vm_switch:network to any -> ($nic_wlan)

pass in quick on $nic_vm_group proto icmp from $nic_vm_switch:network to any icmp-type echoreq
pass in quick on $nic_vm_group proto udp from $nic_vm_switch:network to any port {domain,ntp,mdns,ssdp,bootpc}
pass in quick on $nic_vm_group proto tcp from $nic_vm_switch:network to any
pass in quick on $nic_vm_group proto udp from $nic_vm_switch:network to any port {https,ssdp}
pass out quick on $nic_vm_group proto tcp from $nic_vm_switch:network to $trust_vm_node port ssh
# ==============================

pass quick on $nic_group proto udp from any to any port {domain,ntp,mdns,ssdp,bootpc}

pass quick on $nic_group proto tcp from {"192.168.1.176", "192.168.1.188"} to ($nic_wlan) port {ssh}

pass out quick inet proto icmp all icmp-type echoreq

pass out quick on $nic_group proto tcp from {($nic_wlan)} to any

pass out quick on $nic_group proto udp from {($nic_wlan)} to any port {https,ssdp}

block in quick log(all) on $nic_group from any to {($nic_wlan)}
block out quick log(all) on $nic_group from {($nic_wlan)} to any
block all

```
	```