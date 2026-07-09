# Estimated AWS costs

This project is designed for low-cost learning and portfolio use.

## AWS services used

| Service | What it is used for | Cost driver |
| --- | --- | --- |
| AWS Lambda | Running FastAPI as a container image | Requests and execution time |
| API Gateway HTTP API | Public HTTP endpoint | Number of requests |
| Amazon ECR | Container image storage | Stored GB/month |
| CloudWatch Logs | Lambda logs | Ingested logs and retention |
| IAM / OIDC | Permissions and authentication | Usually no direct cost |

## Cost expectations

For low traffic and testing usage, the cost should usually be very low.

The most likely cost sources are:

1. API Gateway requests.
2. Lambda invocations.
3. CloudWatch logs.
4. ECR image storage.

## Cost optimization choices in this repo

- API Gateway uses HTTP API instead of REST API.
- Lambda memory is set to 512 MB.
- CloudWatch log retention is set to 14 days.
- ECR lifecycle policy keeps only the last 20 images.
- No always-on servers are used.

## How to reduce costs further

You can reduce Lambda memory in:

```text
terraform/variables.tf
```

Example:

```hcl
lambda_memory_size = 256
```

You can reduce log retention in:

```text
terraform/modules/cloudwatch/main.tf
```

Example:

```hcl
retention_in_days = 7
```

## Cleanup

To stop ongoing costs:

```bash
cd terraform
terraform destroy
```
