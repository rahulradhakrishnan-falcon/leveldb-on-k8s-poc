# 📦 LevelDB Application

This folder contains the source code and Dockerfile for the LevelDB-based application.

## 📄 Contents

- `app.py` / `requirements.txt` / etc. — Main application logic
- `Dockerfile` — Used to build a container image for Kubernetes deployment
- Supporting scripts or libraries

## 🛠️ Build Instructions

The Docker image is built using GitHub Actions when any change is detected in this folder:

```bash
docker buildx build --platform linux/amd64 -t <registry>/<project>/leveldb-app:latest .
docker push <registry>/<project>/leveldb-app:latest
