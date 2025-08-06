# Docker build and deploy flow

## Build the image

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

# Shell for container

```
aws ecs execute-command \
  --cluster skyvern-cluster \
  --task 3e00e0af743040538f7848664fb4ae06 \
  --container skyvern-ui \
  --interactive \
  --command "/bin/bash"
```
