# Screenshots for portfolio documentation

Add screenshots to:

```text
docs/images/
```

Recommended screenshots:

## 1. GitHub Actions success

File:

```text
docs/images/github-actions-success.png
```

Capture:

- CI workflow green
- CD workflow green
- Terraform workflow green

## 2. API Gateway

File:

```text
docs/images/api-gateway.png
```

Capture:

- API Gateway HTTP API
- endpoint URL
- routes

## 3. Lambda

File:

```text
docs/images/aws-lambda.png
```

Capture:

- Lambda function
- container image URI
- runtime details

## 4. Swagger UI

File:

```text
docs/images/swagger-aws.png
```

Capture:

```text
https://YOUR_API_ID.execute-api.eu-central-1.amazonaws.com/docs
```

## 5. CloudWatch logs

File:

```text
docs/images/cloudwatch-logs.png
```

Capture:

- Lambda log group
- successful request logs

## README usage

After adding screenshots, you can reference them in README like this:

```md
![GitHub Actions success](docs/images/github-actions-success.png)
![Swagger deployed on AWS](docs/images/swagger-aws.png)
```
