#!/bin/bash

# Ask for user input
read -p "Enter Recruiter's Email: " recruiter_email
read -p "Enter Company Name: " company_name
read -p "Enter Recruiter's Name: " recruiter_name

# Email subject
subject="DevOps Engineer Ready to Accelerate $company_name’s Growth | Immediate Joiner"

# Email body
email_body=$(cat <<EOF
Hi $recruiter_name,

I hope you’re doing well! I’m Atul Rajput, a DevOps Engineer with 1.5+ years of experience building scalable, secure systems. At Aayan Infotech, I’ve automated deployments, optimized cloud-native workflows, and reduced operational toil using Kubernetes, Terraform, and CI/CD pipelines.

Here’s how I’ll add rocket fuel to $company_name:
🚀 Kubernetes Pro: Boosted cluster efficiency by 40% via autoscaling, resource tuning & Prometheus monitoring.
🛠️ Terraform Automation: Built 35+ AWS/GCP environments in minutes (down from hours) with IaC.
⚡ CI/CD Speed Demon: Slashed deployment cycles by 50% using Jenkins/GitLab CI + Docker optimizations.
🔒 DevSecOps Guardrails: Secured pipelines with Trivy/Vault – zero compliance delays.
🤝 Team Multiplier: Mentored 50+ devs on automation – cut manual toil by 20+ hours/month.

I’m inspired by $company_name’s drive to innovate and scale—traits I deeply align with as a DevOps Engineer passionate about building infrastructure that accelerates growth. As an immediate joiner, I’d love to discuss how we can optimize your cloud workflows, harden security, and ship faster.

Let’s connect:
📄 Resume: https://drive.google.com/file/d/1dgE5FbQXnMuydUqZzFneF08ciVn4jA0D/view

Looking forward to the possibility of contributing to $company_name’s success!

Best regards,  
Atul Rajput  
DevOps Engineer  
📞 +91 95206 94904  
📧 atulrajput.work@gmail.com
EOF
)

# Send the email using msmtp
echo -e "Subject:$subject\n\n$email_body" | msmtp --debug -a gmail "$recruiter_email"

echo "✅ Email sent to $recruiter_email"
