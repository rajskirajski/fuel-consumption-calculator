# Lambda image manifest fix

AWS Lambda can reject Docker images when the image manifest or layer media type is not supported.

This patch changes local bootstrap image building and GitHub Actions CD building to use:

```bash
docker buildx build \
  --platform linux/amd64 \
  --provenance=false \
  --sbom=false
```
