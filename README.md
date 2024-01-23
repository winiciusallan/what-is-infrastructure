# What is Infrastructure
IT infrastructure is a set of componenents that together serve to deliver services and computing resources. Among these components are included software, hardware, network, data storage and others.

Nowadays, exists many types of infra. Tha main ones are the traditional and those that use cloud computing.
- Traditional: All components are managed by the company itself in datacenters that are located in their facilities.
- Cloud: Cloud computing is provide the resources across the internet, managed by softwares that delivers machines, storage, network and so on.
Has been more common the use of public Cloud as AWS, Azure, GCP and many others, but you can also build your own cloud environment with Open-source project as [OpenStack](https://www.openstack.org/)

## Understanding infrastructure and virtualization
### Motivations
In the past, is easy to see physical servers with individual tasks, individual purposes, individual operating systems. In a first moment, that seems good, because we separate equally what which server will run, but this
wastes a lot of computing resources that will end up being unused. That way, rises a technology to virtualize that resources which we call **virtualization**.

### How does it work?
<p align="center">
  <img src="https://www.redhat.com/rhdc/managed-files/styles/wysiwyg_float/private/how-virtualization-works-400x217.png?itok=p96ctcWY">
</p>

## Virtual Machine x Container
Some text here (again)

# Infrastructure as Code

## Terraform
### What is it?
Basically, HashiCorp Terraform is a IaC tool that allows you to define cloud and on-prem resources in human-readable configuration files (.yaml / .hcl), this type of format facilitates versioning, encapsulation and also manage low-level components like compute, storage and networking resources, as well as high-level components like DNS entries and SaaS features.

### How does Terraform work?
So, HC Terraform manage cloud plataforms and the other services through their API, it needs the API to be accessible and there to be a provider for the VPC (virtual private cloud). Currently (January 22, 2024), there are 3870 providers that can be found in the [terraform registry](https://registry.terraform.io/browse/providers), some examples are AWS, OpenStack, Hetzner...
<!-- explain providers better-->

<p align="center">
  <img src="https://k21academy.com/wp-content/uploads/2020/08/terraform-providers.png">
</p>

Terraform has a core workflow which consists of three stages:

**Write**, **Plan** and **Apply**
- Write (Refresh) 
At the beginning you define the desired infrastructure provider in a configuration file `main.tf`, In this file you also define resources, such as instances, networks or databases.

- Plan and Init
Review the changes and make sure it will work well when booting.

- Apply 
Terraform provisions the infrastructure and updates the state file.

- Destroy
\:)


## Setup environment (Ubuntu/Debian)
```shell
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

## Getting your hands dirty
Some practice here with terraform, ansible and docker
```hcl
terraform init
```

---
### Referencies
- [What is IT Infrastructure?](https://www.redhat.com/en/topics/cloud-computing/what-is-it-infrastructure)
- [Understanding virtualization](https://www.redhat.com/en/topics/virtualization)
- [What is a virtual machine (VM)?](https://www.redhat.com/en/topics/virtualization/what-is-a-virtual-machine)
- [What is IaC?](https://www.redhat.com/en/topics/automation/what-is-infrastructure-as-code-iac)
- [What is IaaS?](https://www.redhat.com/en/topics/cloud-computing/what-is-iaas)
- [Terraform - Intro](https://developer.hashicorp.com/terraform/intro)