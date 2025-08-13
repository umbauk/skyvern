# About

This app allows users to create and execute workflows for AI agents to execute on websites.

The workflows contain different steps/actions such as logging in to a website, adding an item to a shopping cart etc.

This app is deployed to AWS ECS in production with 2 services: 1) backend service; and 2) UI service.

# Docker build and deploy flow

## Build the UI image

```
# Navigate to your Skyvern project directory (where the Dockerfile.ui is located)
cd /Users/macbookuser/Dev/skyvern

# Build the Docker image with a tag
docker build --platform linux/amd64 -f Dockerfile.ui -t skyvern-ui-custom:latest .

aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern

# Tag your image for ECR
docker tag skyvern-ui-custom:latest 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern:ui-latest

# Push the image to ECR
docker push 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern:ui-latest
```

Select your UI task definition → Create new revision
In Container Definitions → Edit the UI container
Update the Image URI to: 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern:ui-latest

## Build the backend image

```
# Navigate to your Skyvern project directory (where the Dockerfile is located)
cd /Users/macbookuser/Dev/skyvern

# Build the Docker image with a tag
docker build --platform linux/amd64 -f Dockerfile -t skyvern-custom:latest .

aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern

# Tag your image for ECR
docker tag skyvern-custom:latest 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern:backend-latest

# Push the image to ECR
docker push 868807225550.dkr.ecr.us-west-1.amazonaws.com/skyvern:backend-latest

```

# Docker build memory issues

The docker build cache can get large (30GB). When it does, you can prune it with the command `docker builder prune`

# Updating the API key in skyvern-ui on new install

- Get the api key from the organization_credentials table via pgadmin
- Update the API key environment variable in skyvern-ui

# Shell for container

```
aws ecs execute-command \
  --cluster skyvern-cluster \
  --task 3e00e0af743040538f7848664fb4ae06 \
  --container skyvern-ui \
  --interactive \
  --command "/bin/bash"
```
