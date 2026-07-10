# Versioning

The project uses:
1. Application version exposed by `GET /version`.
2. Docker image tags in ECR: `latest` and Git commit SHA.
3. Git release tags, for example:

```bash
git tag v2.0.0
git push origin v2.0.0
```
