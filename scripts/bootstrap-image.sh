#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-eu-central-1}"
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:-207909166461}"
ECR_REPOSITORY="${ECR_REPOSITORY:-fuel-consumption-calculator}"
IMAGE_TAG="${IMAGE_TAG:-bootstrap}"

IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"

echo "Logging in to ECR..."
aws ecr get-login-password --region "${AWS_REGION}" \
  | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "Building image: ${IMAGE_URI}"
docker build -t "${IMAGE_URI}" .

echo "Pushing image..."
docker push "${IMAGE_URI}"

echo "Done: ${IMAGE_URI}"
