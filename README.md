# OpsMate — Containerized Deployment Using Docker and AWS

## Project Overview

OpsMate is a Python Flask-based web service used to demonstrate the complete Docker containerization and AWS deployment workflow.

The project covers:

**Developer → Dockerfile → Docker Image → Docker Container → Docker Compose → Amazon ECR → ECS Task Definition → ECS Service → AWS Fargate → OpsMate Application**

The application provides HTTP endpoints for application and health verification and demonstrates database connectivity using PostgreSQL.

---

## Project Objectives

The main objectives of this project are:

* Understand Docker and containerization.
* Understand Docker architecture and its components.
* Create a Dockerfile for the OpsMate application.
* Build and manage Docker images.
* Create and manage Docker containers.
* Run the application locally using Docker.
* Use Docker Compose for a multi-container application.
* Connect the application container with a PostgreSQL database container.
* Create and use a Docker network.
* Use a persistent Docker volume for PostgreSQL data.
* Store Docker images in Amazon ECR.
* Deploy the application using Amazon ECS.
* Run the application using AWS Fargate.
* Configure ECS task definitions and services.
* Configure container health checks.
* Configure CloudWatch logging and monitoring.
* Verify the deployed application through a public endpoint.
* Practice Git and GitHub version control.

---

## Technologies Used

| Technology        | Purpose                        |
| ----------------- | ------------------------------ |
| Python            | Application runtime            |
| Flask             | Web application framework      |
| Docker            | Application containerization   |
| Docker Compose    | Multi-container orchestration  |
| PostgreSQL        | Database                       |
| Amazon ECR        | Docker image registry          |
| Amazon ECS        | Container orchestration        |
| AWS Fargate       | Serverless container execution |
| Amazon CloudWatch | Logs and monitoring            |
| AWS IAM           | Access control                 |
| Ubuntu Linux      | Docker host                    |
| Git               | Version control                |
| GitHub            | Source code repository         |

---

## Project Structure

```text
opsmate/
│
├── Dockerfile
├── app.py
├── compose.yaml
├── requirements.txt
├── .dockerignore
├── .gitignore
├── docker-deployment-report.txt
├── README.md
│
├── config/
│   └── environment.example
│
├── scripts/
│   ├── install-docker.sh
│   ├── build-image.sh
│   ├── run-container.sh
│   └── cleanup.sh
│
├── screenshots/
│   ├── docker-installation.png
│   ├── docker-daemon.png
│   ├── docker-image.png
│   ├── docker-container.png
│   ├── application-running.png
│   ├── docker-compose.png
│   ├── ecr-repository.png
│   ├── ecr-image.png
│   ├── ecs-cluster.png
│   ├── ecs-task.png
│   └── fargate-application.png
│
└── documentation/
    └── Docker-Architecture.png
```

---

# 1. Docker Containerization

Containerization packages an application together with its runtime, dependencies, libraries and configuration so that it can run consistently across different environments.

Docker provides lightweight containers that share the host operating system kernel while keeping applications isolated.

### Virtual Machine vs Docker Container

| Virtual Machine                      | Docker Container            |
| ------------------------------------ | --------------------------- |
| Includes complete guest OS           | Shares host OS kernel       |
| Higher resource usage                | Lightweight                 |
| Slower startup                       | Fast startup                |
| Requires more storage                | Requires less storage       |
| Strong hardware-level virtualization | Application-level isolation |

---

# 2. Docker Architecture

The major Docker components used in this project are:

* **Docker Client** — command-line interface used to interact with Docker.
* **Docker Engine** — platform responsible for building and running containers.
* **Docker Daemon** — background service that manages Docker objects.
* **Docker Image** — read-only template used to create containers.
* **Docker Container** — running instance of an image.
* **Docker Registry** — stores Docker images.
* **Docker Hub** — public Docker registry.
* **Amazon ECR** — AWS private container registry used in this project.

### Project Architecture

```text
Developer
    │
    ▼
Dockerfile
    │
    ▼
Docker Image
    │
    ├──────────────► Docker Container
    │                     │
    │                     ▼
    │                OpsMate App
    │
    ▼
Amazon ECR
    │
    ▼
ECS Task Definition
    │
    ▼
ECS Service
    │
    ▼
AWS Fargate
    │
    ▼
OpsMate Application
```

---

# 3. Docker Installation

Docker was installed on an Ubuntu EC2 instance.

Important verification commands:

```bash
docker --version
docker info
docker ps
docker images
sudo systemctl status docker
```

Docker service management:

```bash
sudo systemctl start docker
sudo systemctl stop docker
sudo systemctl restart docker
sudo systemctl enable docker
```

Docker installation was verified using:

```bash
docker run hello-world
```

---

# 4. OpsMate Application

The application is implemented using Python and Flask.

The main application file is:

```text
app.py
```

Python dependencies are defined in:

```text
requirements.txt
```

The application listens on port:

```text
5000
```

---

# 5. Dockerfile

The Dockerfile defines how the OpsMate Docker image is created.

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
```

### Dockerfile Instructions

| Instruction | Purpose                                 |
| ----------- | --------------------------------------- |
| FROM        | Selects the base Python image           |
| WORKDIR     | Sets the application working directory  |
| COPY        | Copies application files into the image |
| RUN         | Installs Python dependencies            |
| EXPOSE      | Documents application port              |
| CMD         | Starts the application                  |

---

# 6. Building the Docker Image

The image was built using:

```bash
docker build -t opsmate:1.0 .
```

Images were verified using:

```bash
docker images
```

Image inspection:

```bash
docker inspect opsmate:1.0
```

---

# 7. Running the Docker Container

The application container can be started using:

```bash
docker run -d \
  --name opsmate-app \
  -p 5000:5000 \
  opsmate:1.0
```

Verify the running container:

```bash
docker ps
```

View all containers:

```bash
docker ps -a
```

View container logs:

```bash
docker logs opsmate-app
```

Inspect the container:

```bash
docker inspect opsmate-app
```

---

# 8. Container Management Commands

Stop:

```bash
docker stop opsmate-app
```

Start:

```bash
docker start opsmate-app
```

Restart:

```bash
docker restart opsmate-app
```

Remove:

```bash
docker rm opsmate-app
```

Remove an image:

```bash
docker rmi opsmate:1.0
```

---

# 9. Docker Compose

Docker Compose is used to run multiple related containers as one application stack.

The project contains:

```text
compose.yaml
```

The Compose application contains:

```text
OpsMate Application Container
          │
          │ Docker Network
          ▼
PostgreSQL Database Container
```

The application container uses the database service name:

```text
database
```

The PostgreSQL container uses persistent storage through:

```text
postgres-data
```

---

## Docker Compose Commands

Start the complete application:

```bash
docker compose up -d
```

Check services:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs
```

View application logs:

```bash
docker compose logs app
```

View database logs:

```bash
docker compose logs database
```

Stop the Compose application:

```bash
docker compose down
```

---

# 10. Docker Network

The application and PostgreSQL containers communicate through the Docker network:

```text
opsmate-network
```

The application connects to PostgreSQL using:

```text
DB_HOST=database
DB_PORT=5432
```

Docker Compose provides service-name based container communication.

---

# 11. Docker Volume

PostgreSQL data is stored using the Docker volume:

```text
postgres-data
```

This provides persistent database storage even when the PostgreSQL container is recreated.

---

# 12. Amazon ECR

Amazon Elastic Container Registry (ECR) is AWS's managed private container registry.

The OpsMate Docker image was pushed to ECR.

### ECR Repository

```text
opsmate
```

### ECR Image URI

```text
452183714498.dkr.ecr.ap-south-1.amazonaws.com/opsmate
```

Images were tagged and pushed to the ECR repository.

Example:

```bash
docker tag opsmate:2.0 \
452183714498.dkr.ecr.ap-south-1.amazonaws.com/opsmate:2.0
```

Push:

```bash
docker push \
452183714498.dkr.ecr.ap-south-1.amazonaws.com/opsmate:2.0
```

ECR was used as the image source for the ECS deployment.

---

# 13. Amazon ECS

Amazon Elastic Container Service (ECS) is used to run and manage containers.

The project uses the ECS cluster:

```text
opsmate-cluster
```

The ECS service is:

```text
opsmate-service
```

The task definition used for deployment is:

```text
opsmate-task
```

---

# 14. ECS Task Definition

The ECS task definition specifies how the OpsMate container should run.

It defines:

* Container image
* CPU
* Memory
* Container port
* Environment variables
* Logging configuration
* Health check
* Execution role

The deployed task definition reached revision:

```text
opsmate-task:6
```

---

# 15. AWS Fargate

AWS Fargate is used as the compute engine for the ECS service.

Fargate allows containers to run without manually managing EC2 servers for the container workload.

Deployment flow:

```text
Docker Image
     │
     ▼
Amazon ECR
     │
     ▼
ECS Task Definition
     │
     ▼
ECS Service
     │
     ▼
AWS Fargate
     │
     ▼
OpsMate Container
```

---

# 16. ECS Service

The ECS service maintains the desired number of running tasks.

Project service:

```text
opsmate-service
```

Launch type:

```text
Fargate
```

The deployed task was verified as:

```text
Last Status: RUNNING
Health: HEALTHY
```

---

# 17. Application Verification

The deployed application was successfully accessed through the Fargate public endpoint.

The browser displayed:

```text
OpsMate Service v2 is running successfully!
```

This verified that:

* Docker image was successfully built.
* Image was pushed to ECR.
* ECS task definition successfully referenced the image.
* ECS service successfully started the task.
* Fargate successfully launched the container.
* The application was reachable through the public endpoint.

---

# 18. Health Check

The application provides a health verification endpoint.

Expected response:

```text
OpsMate Health: OK
```

Health checks help determine whether the application container is functioning correctly.

---

# 19. CloudWatch Logging

Amazon CloudWatch was used for container log monitoring.

The ECS deployment was configured to send application logs to CloudWatch.

This allows troubleshooting of:

* Application startup
* Runtime errors
* Container failures
* Application requests
* Deployment issues

---

# 20. Updating the Application

The project demonstrates versioned Docker image deployment.

Example workflow:

```text
Modify Application
       │
       ▼
Build New Docker Image
       │
       ▼
Tag Image
       │
       ▼
Push Image to ECR
       │
       ▼
Update ECS Task Definition
       │
       ▼
Update ECS Service
       │
       ▼
Fargate Starts New Task
       │
       ▼
Verify Application
```

The updated application was deployed as:

```text
OpsMate Service v2
```

---

# 21. Troubleshooting

Common Docker troubleshooting commands used in the project include:

```bash
docker ps
docker ps -a
docker images
docker logs <container>
docker inspect <container>
docker info
docker stats
```

For Docker Compose:

```bash
docker compose ps
docker compose logs
docker compose logs app
docker compose logs database
```

For ECS:

```text
ECS Cluster
    ↓
ECS Service
    ↓
ECS Task
    ↓
Container
    ↓
CloudWatch Logs
```

These components can be checked when troubleshooting deployment failures.

---

# 22. Security Considerations

The project follows basic container and AWS security practices:

* Do not commit AWS access keys or secret credentials.
* Do not store real passwords in public repositories.
* Use IAM roles for AWS services.
* Restrict security group access to required ports.
* Expose only required application ports.
* Use private ECR repositories for container images.
* Use environment variables or AWS Secrets Manager for sensitive configuration in production.
* Avoid running containers with unnecessary privileges.

---

# 23. Docker Image Optimization

The project uses:

```dockerfile
FROM python:3.12-slim
```

instead of a larger full Python image.

The Dockerfile also uses:

```dockerfile
RUN pip install --no-cache-dir -r requirements.txt
```

to avoid retaining pip's package cache inside the image.

A `.dockerignore` file is used to prevent unnecessary files from being included in the Docker build context.

---

# 24. Future Improvements

Possible future improvements include:

* AWS Secrets Manager integration.
* HTTPS using Application Load Balancer.
* Custom domain name.
* Auto Scaling.
* CI/CD using GitHub Actions or Jenkins.
* Infrastructure as Code using Terraform.
* Amazon RDS instead of a containerized PostgreSQL database for production.
* Container vulnerability scanning.
* Amazon ECR image scanning.
* Improved application monitoring.
* Production-grade logging and alerting.

---

# 25. Final Architecture

```text
                         Developer
                             │
                             ▼
                         GitHub
                             │
                             ▼
                        Dockerfile
                             │
                             ▼
                       Docker Image
                             │
                    ┌────────┴────────┐
                    │                 │
                    ▼                 ▼
             Local Docker       Amazon ECR
                    │                 │
                    ▼                 ▼
             Docker Container   ECS Task Definition
                                      │
                                      ▼
                                 ECS Service
                                      │
                                      ▼
                                  Fargate
                                      │
                                      ▼
                              OpsMate Container
                                      │
                                      ▼
                              Public Endpoint
                                      │
                                      ▼
                              OpsMate Service
```

---

# 26. Complete Project Workflow

```text
1. Develop OpsMate application
          ↓
2. Create Dockerfile
          ↓
3. Build Docker image
          ↓
4. Run Docker container
          ↓
5. Verify application
          ↓
6. Create Docker Compose environment
          ↓
7. Connect application with PostgreSQL
          ↓
8. Create ECR repository
          ↓
9. Tag Docker image
          ↓
10. Push image to ECR
          ↓
11. Create ECS task definition
          ↓
12. Create ECS service
          ↓
13. Launch container using Fargate
          ↓
14. Configure health checks
          ↓
15. Configure CloudWatch logging
          ↓
16. Verify application
          ↓
17. Build and deploy updated version
```

---

# 27. Project Result

The OpsMate application was successfully containerized using Docker and deployed to AWS using Amazon ECR, Amazon ECS and AWS Fargate.

The final deployment successfully demonstrated:

* Docker image creation
* Docker container execution
* Docker Compose
* PostgreSQL container
* Docker networking
* Docker persistent volumes
* Amazon ECR
* Amazon ECS
* ECS Task Definition
* ECS Service
* AWS Fargate
* Container health checks
* CloudWatch logging
* Application deployment and verification
* Versioned application update

The final application was successfully verified through the deployed Fargate endpoint.

---

## Conclusion

This project provided practical experience with the complete container lifecycle, from creating a Dockerfile and building an image to storing the image in Amazon ECR and deploying the application through ECS and AWS Fargate.

It also demonstrated multi-container application deployment using Docker Compose, database connectivity, persistent storage, container networking, health monitoring, logging and troubleshooting.

The project establishes a foundation for further DevOps practices such as CI/CD, Infrastructure as Code, container security, monitoring and production-grade AWS deployments.

