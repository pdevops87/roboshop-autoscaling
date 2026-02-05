# roboshop-autoscaling
creating mutiple instances automatically through autoscaling group


* click on "launch template"
* Launch template name:
* Launch template description:
* click on "Recently Launched"
* enter/choose ami
* choose instance type
* key pair login
* create/select security group
* create a launch template


* Now create an autoscaling group:
* name: test
* choose launch template
* choose vpc
* choose availability zones,click on next
* no need to select anything in this page , click on Next
* Desire Capacity: 2
* Min Desire Capacity: 2
* Max Desire Capacity: 2
* click on Next
* click on Next
* create "Auto Scaling Group"
* now "instances are created"
* manually use the instances and install nginx and start the nginx service

Autoscaling group increase the desired capacity[increase instances] , here there is a limitation every time manually install nginx and start the nginx service
so to avoid this problem there is a "nginx reverse proxy for multiple servers" 

problem:
========
if we launch a new instance (desired capacity) again we need to install and start nginx .
this is not a good way

How cloud-init works (step by step)
===================================
VM boots
↓
cloud-init starts
↓
cloud-init fetches metadata
↓
cloud-init fetches user data
↓
cloud-init applies config
↓
VM ready

What is cloud-init? (plain English)
====================================
cloud-init is a startup agent inside a virtual machine that:

reads configuration (user data + metadata)
and automatically configures the VM on first boot

🔹 User data
==============
Provided by you:

* Shell scripts
* YAML config
* cloud-config

Example user data:
==================
#!/bin/bash
yum install -y nginx
systemctl start nginx


*************************
to check nginx is running or not
cd /var/log
cat clout-init-output.log
cloud-init --help
cloud-init init
cloud-init modules --mode=config ::: Run only the “config” stage modules again
Fully rerun everything (most common)
====================================
cloud-init clean
reboot
* cloud-init --all-stages 

| Command          | What happens         |
| ---------------- | -------------------- |
| `--mode=config`  | Re-apply config      |
| `--mode=final`   | Re-run final scripts |
| `clean + reboot` | Full rerun           |




example code:
==============
http {
# Define backend servers
upstream backend_servers {
server 192.168.1.101;
server 192.168.1.102;
}

    server {
        listen 80;

        location / {
            # Forward requests to backend_servers
            proxy_pass http://backend_servers  // backend_servers are upstream servers;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}

here also there is an issue like every time manually install nginx and start service

upstream backend_servers: Defines a group of backend servers.
proxy_pass http://backend_servers;: Sends requests to one of the servers in the group.
proxy_set_header: Passes client info to backend servers.

either we add ip address/dns names in upstream code , manually enter the application code and run so to avoid this limitation we have to go LB.



shebang(#!):
=============
cd /tmp
echo $SHELL
for i in apple banana citrus; do echo $i; done
cd /tmp 
cd >/tmp bash
vi 1
for i in apple banana citrus; do echo $i; done
chmod+x 1
./1 : to run script without bash interpreter
// will get an error
vi 1
#!/bin/zsh
Load Balancer:
==============
To distribute the traffic in different resources/ec2/nodes



==============================================================================

step1:
======
1. create launch template
2. create autoscaling group and attach launch template 
3. two desired capacity (instance) are created
4. install nginx in both instances manually

upto now we install configuration only in single nodes like frontend(nginx)
we need to distribute the traffic of multiple servers
how to send the traffic to multiple nodes?
LB

step2:
======
how to run script/yaml in an instance automatically during launch an instance?
by adding some scripts in  userdata in a launch template
create a normal ec2 instance and add script in user data

#!/bin/bash
dnf install nginx -y
systemctl start nginx


step3:
=======
Launch template and add script in userdata
create autoscaling group and add launch template

cloud-init:
============
cloud-init is a tool inside the VM that reads user data (and cloud metadata) at first boot and automatically configures the VM according to that data

Key points to make it precise:
==============================
User Data: Scripts or YAML you provide (e.g., installing NGINX, setting up users).
Metadata: Information from the cloud provider (hostname, network config, SSH keys).
Automatic configuration: cloud-init executes tasks like:
Installing packages
Starting services
Configuring network or hostname
Creating users or keys

Runs mostly at first boot: Logs are stored in /var/log/cloud-init-output.log and state in /var/lib/cloud/.


                   ┌─────────────────┐
                   │     Clients     │
                   └────────┬────────┘
                            │
                            ▼
                ┌───────────────────────┐
                │   Load Balancer (LB)  │
                │   Distributes traffic │
                │   across frontends   │
                └────────┬─────────────┘
                         │
      ┌──────────────────┴──────────────────┐
      ▼                                     ▼
┌───────────────┐                     ┌───────────────┐
│ Frontend A    │                     │ Frontend B    │
│ (Web Server)  │                     │ (Web Server)  │
└───────┬───────┘                     └───────┬───────┘
│                                     │
│                                     │
▼                                     ▼
┌───────────┐                         ┌───────────┐
│ Catalogue │                         │ Catalogue │
└───────────┘                         └───────────┘
│                                     │
▼                                     ▼
┌───────────┐                         ┌───────────┐
│   User    │                         │   User    │
└───────────┘                         └───────────┘
│                                     │
▼                                     ▼
┌───────────┐                         ┌───────────┐
│   Cart    │                         │   Cart    │
└───────────┘                         └───────────┘
│                                     │
▼                                     ▼
┌───────────┐                         ┌───────────┐
│ Shipping  │                         │ Shipping  │
└───────────┘                         └───────────┘
│                                     │
▼                                     ▼
┌───────────┐                         ┌───────────┐
│ Payment   │                         │ Payment   │
└───────────┘                         └───────────┘




🔹 Explanation

Load Balancer (LB): Receives all client requests and distributes them across multiple frontend servers (Frontend A, Frontend B).
Frontend Servers: Each frontend server receives requests from the LB one-to-one per request.
Backend Services: Each frontend server then orchestrates requests to multiple backend services (Catalogue, User, Cart, Shipping, Payment).

Key point:
==========
LB distributes traffic among frontend servers
Frontend servers call multiple backend services, but this is request orchestration, not LB-style distribution.


Listeners and routing Info
A listener is a process that checks for connection requests using the port and protocol you configure. The rules that you define for a listener determine how the load balancer routes requests to its registered targets.

Routing action
Forward to target groups
Redirect to URL
Return fixed response
Forward to target group
Info
Choose a target group and specify routing weight or create target group .



