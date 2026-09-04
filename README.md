The project demonstrates the complete container deployment workflow:

Developer → Dockerfile → Docker Image → Amazon ECR → ECS Task Definition → ECS Service → AWS Fargate → OpsMate Application

The application exposes HTTP endpoints for application and health verification and includes database connectivity testing with PostgreSQL.

---

## Objectives

The main objectives of this project are:

- Containerize the OpsMate application using Docker.
- Build and test the Docker image locally.
- Run the application using Docker containers.
- Use Docker Compose for application and PostgreSQL database deployment.
- Store the Docker image in Amazon Elastic Container Registry (ECR).
- Deploy the application using Amazon ECS with AWS Fargate.
- Configure container health checks.
- Configure CloudWatch logging and monitoring.
- Verify the deployed application through its public endpoint.

---

## Technologies Used

- Python
- Flask
- Docker
- Docker Compose
- PostgreSQL
- Amazon ECR
- Amazon ECS
- AWS Fargate
- Amazon CloudWatch
- AWS IAM
- Linux / Ubuntu
- Git
- GitHub

---

## Project Structure

```text
opsmate/
│
├── Dockerfile
├── app.py
├── compose.yaml
├── requirements.txt
├── .gitignore
└── README.md# OpsMate — Containerized Deployment Using Docker and AWS

## Project Overview

OpsMate is a Python Flask-based web service that has been containerized using Docker an
