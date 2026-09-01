# Azure Virtual Network (Vnet) Traffic flow and security
A hands-on cloud networking lab focused on designing, configuring, and securing custom Azure Virtual Network (Vnet) infrastructure on Azure.
The lab focuses on understanding how network traffic flows between Azure resources and how **Network Security Groups (NSGs), route tables, and subnet** can be used to control and secure communication.


## 🏗️ Architecture

![Architecture](architecture.png)



### Key Concepts

* Azure Virtual Network (VNet)
* Subnets
* Network Security Groups (NSGs)
* Private and public IP addresses
* Azure Virtual Machines
* Route Tables / User Defined Routes
* Inbound and outbound traffic
* ICMP/TCP traffic testing
* Network security rules
* Traffic flow troubleshooting
* Least-privilege network access


# 🎯 Project Objectives

1. Create a custom Azure VNet.
2. Divide the VNet into multiple subnets.
3. Deploy virtual machines into different subnets.
4. Configure NSGs at subnet/NIC level.
5. Control inbound and outbound traffic.
6. Understand Azure's default routing behavior.
7. Create custom route tables.
8. Test communication between subnets.
9. Block unauthorized traffic.
10. Troubleshoot connectivity using Azure networking tools.
11. Document network traffic flow.
12. Apply basic cloud security best practices.

---

# ☁️ Azure Resources

The project uses:

| Resource        | Purpose                          |
| --------------- | -------------------------------- |
| Resource Group  | Container for lab resources      |
| Virtual Network | Private network infrastructure   |
| Web Subnet      | Web-facing workload              |
| App Subnet      | Application workload             |
| DB Subnet       | Database workload                |
| NSG             | Traffic filtering                |
| Route Table     | Custom traffic routing           |
| VM-01           | Web server                       |
| VM-02           | Application server               |
| VM-03           | Database/test server             |
| Public IP       | Controlled administrative access |

---

# 🔐 NSG Security Design

The network follows a basic **least-privilege** model.

## Web NSG

Allow:

```text
SSH 22     → Administration
HTTP 80    → Web traffic
HTTPS 443  → Secure web traffic
```

Deny unnecessary inbound traffic.

Example:

| Priority | Rule        | Port | Source   | Action |
| -------- | ----------- | ---: | -------- | ------ |
| 100      | Allow-SSH   |   22 | My IP    | Allow  |
| 110      | Allow-HTTP  |   80 | Internet | Allow  |
| 120      | Allow-HTTPS |  443 | Internet | Allow  |
| 4000     | Deny-All    |    * | Internet | Deny   |

---

# 🔒 App NSG

Application servers should not be directly exposed to the Internet.

Example:

| Priority | Rule      | Port | Source        | Action |
| -------- | --------- | ---: | ------------- | ------ |
| 100      | Allow-App | 8080 | Web Subnet    | Allow  |
| 200      | Allow-SSH |   22 | Admin Network | Allow  |
| 4000     | Deny-All  |    * | Internet      | Deny   |

---

# 🛡️ Database NSG

The database subnet should only accept traffic from the application layer.

Example:

| Priority | Rule      | Port | Source        | Action |
| -------- | --------- | ---: | ------------- | ------ |
| 100      | Allow-DB  | 1433 | App Subnet    | Allow  |
| 200      | Allow-SSH |   22 | Admin Network | Allow  |
| 4000     | Deny-All  |    * | Internet      | Deny   |

> The database VM should not have a public IP address.


Associate them with their corresponding subnets.

Configure rules according to the security model above.

---

# 🧰 Technologies

```text
Microsoft Azure
Azure Virtual Network
Azure Subnets
Network Security Groups
Azure Route Tables
Azure Virtual Machines
Linux
TCP/IP
ICMP
SSH
HTTP/HTTPS
Terraform
Git
GitHub
```

---


# 📈 Expected Learning Outcomes

After completing this project, you should be able to explain:

* How Azure VNets work
* How subnetting works in Azure
* How private IP communication works
* How NSGs filter traffic
* How inbound and outbound rules are evaluated
* How Azure routing works
* How User Defined Routes change traffic paths
* How to troubleshoot connectivity
* How to design a segmented cloud network
* How to apply least-privilege network security
* How to automate Azure infrastructure with Terraform

---

# 💡 Optional Advanced Challenges

Once the basic lab works, extend it.

## Challenge 1 — Azure Firewall

Create:

```text
Internet
   ↓
Azure Firewall
   ↓
Web Subnet
   ↓
App Subnet
   ↓
DB Subnet
```

Implement centralized traffic inspection.

---

## Challenge 2 — Bastion

Remove public IPs from the VMs and use Azure Bastion for administrative access.

---

## Challenge 3 — Private DNS

Create a private DNS zone and access services using names instead of IP addresses.

Example:

```text
app.internal
db.internal
```

---

## Challenge 4 — NSG Flow Logs

Enable network traffic logging and analyze accepted/denied flows.

---

## Challenge 5 — Infrastructure as Code

Recreate the entire environment using Terraform.

The goal should be:

```bash
terraform init
terraform plan
terraform apply
```

and the complete networking lab is created automatically.

---

