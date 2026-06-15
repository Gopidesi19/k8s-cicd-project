# k8s-cicd-project

# End-to-End CI/CD Deployment on GKE

## Overview

This project demonstrates an end-to-end DevOps workflow using:

- Flask
- Docker
- GitHub Actions
- Trivy
- Google Artifact Registry
- GKE
- Terraform
- Helm
- Prometheus
- Grafana

---

## Application Endpoints

| Endpoint | Description |
|----------|-------------|
| / | Application details |
| /health | Health check |
| /version | Application version |

---

## Local Setup

### Clone the Repository

```bash
git clone https://github.com/<your-username>/k8s-cicd-project.git
cd k8s-cicd-project
```

### Create Virtual Environment

```bash
python -m venv venv
```

Activate the environment:

Linux/macOS:

```bash
source venv/bin/activate
```

Windows:

```powershell
venv\Scripts\activate
```

### Install Dependencies

```bash
pip install -r app/requirements.txt
```

### Run the Application

```bash
python app/app.py
```

Open:

```
http://localhost:5000
```

---

## Run Unit Tests

```bash
pytest app/tests/
```

---

## Docker Commands

Build the Docker image:

```bash
docker build -t flask-gke-app:v1 .
```

Run the container:

```bash
docker run -d -p 5000:5000 flask-gke-app:v1
```

Verify:

```bash
curl http://localhost:5000/health
```

---

## Upcoming Enhancements

- Terraform for GKE provisioning
- Google Artifact Registry integration
- GitHub Actions CI/CD pipeline
- Trivy vulnerability scanning
- Helm deployments
- Prometheus and Grafana monitoring
