# Unit 06 - Load Balancer

## Overview
Created a third Windows Server EC2 instance, installed IIS using
the script from Unit 05, configured an AWS Application Load Balancer
to distribute traffic between both web servers, and simulated taking
a server offline for maintenance.

## What Was Asked
1. Create a third Windows Server EC2 instance
2. Use the Unit 05 PowerShell script to install IIS on the new server
3. Configure an AWS load balancer to balance traffic between both web servers
4. Remove one server from the load balancer to simulate maintenance

## What I Did

**Launched third EC2 instance:**

| Setting | Value |
|---------|-------|
| AMI | Windows Server 2019 Base |
| Instance type | t2.micro (free tier) |
| VPC | Same VPC as existing servers |
| Availability Zone | Same AZ as existing servers |

**Installed IIS using existing script:**
```powershell
.\01-install-iis.ps1
```

**Created a Target Group in AWS:**

> EC2 Console > Load Balancing > Target Groups > Create Target Group

| Setting | Value |
|---------|-------|
| Target type | Instances |
| Protocol | HTTP |
| Port | 80 |
| VPC | Same VPC as both servers |
| Health check path | / |
| Targets | Both web server instances registered |

**Created Application Load Balancer:**

> EC2 Console > Load Balancing > Load Balancers > Create Load Balancer

| Setting | Value |
|---------|-------|
| Type    | Application Load Balancer |
| Scheme  | Internet-facing |
| Listener| HTTP port 80 |
| Availability Zones | AZ where both servers live |
| Security Group | Allow inbound HTTP port 80 |
| Target Group | Forward to target group created above |

**Verified load balancer was working:**

**Removed a server from the load balancer for maintenance:**

> EC2 Console > Load Balancing > Target Groups > Select Target Group

| Step | Action |
|------|--------|
| 1 | Select the instance to take offline |
| 2 | Actions > Deregister |
| 3 | Verified remaining server was handling all traffic via ALB DNS name |

## What I Learned
- A target group sits between the load balancer and the instances 
  the ALB forwards to the target group, not directly to instances
- Health checks are how the ALB decides if an instance is ready
  to receive traffic if IIS is not running the instance fails
  the health check and gets removed from rotation
- Both servers need to be in the same VPC for the ALB to route to them
- Reusing the script from Unit 05 saved time and confirmed the
  script works reliably across multiple servers
- Deregistering a target gracefully removes it from rotation without
  affecting the load balancer or the other server
- This is the correct way to take a server offline for maintenance
  in a production environment never stop an instance while it is
  still registered in the target group

