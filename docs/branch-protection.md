# Branch protection setup

Configure manually in GitHub:

Repository -> Settings -> Branches -> Add branch protection rule

Recommended:
- Branch pattern: main
- Require a pull request before merging.
- Require status checks to pass before merging.
- Require branches to be up to date before merging.
- Disable force pushes.
- Disable deletions.
