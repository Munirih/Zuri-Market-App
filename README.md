# Zuri Market e-commerce Platform Deployment to Kubernetes (K3s)

## 1. Project Overview

This project demonstrates a DevSecOps deployment pipeline for a containerized full-stack application running on Kubernetes (K3s) hosted on AWS EC2.

The project demonstrates modern DevOps and DevSecOps practices including:

- AWS Infrastructure provisioning with Terraform
- Remote Terraform State Management with state locking (S3 Bucket)
- Containerization with Docker
- GitHub Actions for Continuous Integration and Continuous Deployment (CI/CD)
- Application Dependencies and Container Vulnerability Scanning using Trivy
- Secret Management with AWS Secrets Manager
- IAM Roles with least privilege for Secure Access
- AWS SDK for runtime secrets retrieval
- Application Deployment to Kubernetes Cluster using Deployments and Services and Ingress objects



[Frontend Documentation](./documentation/frontend-documentation.md)

[Backend Documentation](./documentation/backend-documentation.md)


