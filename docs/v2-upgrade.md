# Version 2.0 upgrade

Adds Dependabot, Trivy, pip-audit, Checkov, CHANGELOG and Terraform `ignore_changes` for Lambda `image_uri`.

`ignore_changes` is used because Terraform manages infrastructure, while GitHub Actions CD manages deployed image versions.
