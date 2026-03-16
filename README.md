# 🚀 CI/CD Pipeline with Docker & AWS EC2 Auto Deployment

This project demonstrates how to build a **production-style CI/CD pipeline using GitHub Actions** that automatically builds a Docker image, pushes it to DockerHub, and deploys the application to an AWS EC2 server.

The pipeline is designed to simulate how modern DevOps teams automate application delivery using **CI/CD automation, containerization, and cloud infrastructure**.

---

# 📌 What is CI/CD?

CI/CD stands for:

**Continuous Integration (CI)**  
Developers frequently push code to a shared repository where automated pipelines build and test the application.

**Continuous Deployment (CD)**  
After successful builds and tests, the application is automatically deployed to the production server.

Traditional workflow:

Developer → Manual build → Manual deployment

Modern DevOps workflow:

Developer → GitHub → CI/CD Pipeline → Automated Deployment

Benefits:

• Faster releases  
• Fewer human errors  
• Automated testing  
• Consistent deployments

---

# 🧰 Technologies Used

| Tool | Purpose |
|-----|------|
| GitHub Actions | CI/CD automation |
| Docker | Containerization |
| DockerHub | Container image registry |
| AWS EC2 | Application hosting server |
| Node.js | Sample web application |

---

# 📂 Project Structure
docker-ci-cd-pipeline
│
├── app
│ ├── app.js
│ └── package.json
│
├── Dockerfile
│
└── .github
└── workflows
└── cicd-ec2-auto-deploy.yml


Explanation:

app → Node.js web application  
Dockerfile → instructions to build container image  
.github/workflows → GitHub Actions pipeline configuration

---

# ⚙️ Application Code

The application is a simple Node.js Express server.

File: app/app.js

Example:

```javascript
const express = require("express")

const app = express()

app.get("/", (req,res)=>{
    res.send("CI/CD Docker Pipeline Working 🚀")
})

app.listen(3000, ()=>{
    console.log("Server running on port 3000")
})

##  When running the application, opening:

http://SERVER_IP:3000

returns:

CI/CD Docker Pipeline Working 🚀

Docker Containerization

The application is packaged into a Docker container.

File:

Dockerfile

Example:
FROM node:18

WORKDIR /app

COPY app/package.json .

RUN npm install

COPY app .

EXPOSE 3000

CMD ["npm","start"]

Explanation:

FROM → base container image
WORKDIR → container working directory
COPY → copy application files
RUN → install dependencies
EXPOSE → application port
CMD → start the application

CI/CD Pipeline Workflow

This pipeline runs manually using workflow_dispatch in GitHub Actions.

Pipeline stages:

1️⃣ Checkout Code
2️⃣ Install Dependencies
3️⃣ Run Application Test
4️⃣ Build and Push Docker Image
5️⃣ Deploy Container on AWS EC2
############################################################################
1️⃣ Checkout Stage

The pipeline first downloads the repository source code.

uses: actions/checkout@v4

Purpose:

• Retrieves the latest version of the repository
• Makes the source code available to the GitHub runner
############################################################
2️⃣ Install Dependencies Stage

Node.js runtime is installed and project dependencies are downloaded.

uses: actions/setup-node@v4

Then dependencies are installed:

cd app
npm install

Purpose:

• Install required Node.js libraries
• Prepare the application for testing
###########################################################################
3️⃣ Application Testing Stage

The pipeline starts the application temporarily and verifies that the service responds correctly.

node app.js &
sleep 5
curl http://localhost:3000

Explanation:

node app.js → starts the Node.js server
sleep 5 → waits for server to start
curl → sends HTTP request to verify server response

If the application responds successfully, the pipeline continues.
######################################################################################
4️⃣ Docker Build and Push Stage

After successful testing, the application is packaged into a Docker image.

Docker image build:

docker build -t username/cicd-ec2-app:latest .

DockerHub login:

uses: docker/login-action@v3

Push image to DockerHub:

docker push username/cicd-ec2-app:latest

Purpose:

• Package application into a container
• Store container image in DockerHub registry
#########################################################################################
5️⃣ EC2 Deployment Stage

After pushing the image, the pipeline connects to the EC2 server via SSH.

The deployment process executes these commands on the server:

docker pull username/cicd-ec2-app:latest

docker stop cicd-ec2-app || true
docker rm cicd-ec2-app || true

docker run -d -p 3000:3000 \
--name cicd-ec2-app \
username/cicd-ec2-app:latest

Explanation:

docker pull → download latest container image
docker stop → stop existing container
docker rm → remove old container
docker run → start new container

This ensures the server always runs the latest application version.
###########################################################################################
🔐 Required GitHub Secrets

To enable secure deployment, the following secrets must be configured in the repository settings:

DOCKER_USERNAME
DOCKER_PASSWORD
EC2_HOST
EC2_USER
EC2_SSH_KEY

These secrets allow GitHub Actions to:

• authenticate with DockerHub
• securely connect to the EC2 server
################################################################################################
Access the Application

After deployment, the application is accessible at:

http://EC2_PUBLIC_IP:3000

###############################################################################################
What This Project Demonstrates

This project demonstrates real-world DevOps practices:

• CI/CD pipeline automation
• Docker containerization
• Cloud deployment on AWS
• Infrastructure automation
• Secure credential management

Key Learnings

Through this project I learned how to:

• automate CI/CD pipelines using GitHub Actions
• build Docker container images
• push images to DockerHub
• deploy containers to AWS EC2
• automate application deployment workflows
############################################################################################
