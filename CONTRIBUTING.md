# Contributing to the Next.js/Terraform Project
We welcome contributions! Whether you're fixing bugs, improving documentation, or adding new infrastructure features, your help is appreciated.

Please follow these guidelines to ensure a smooth contribution process.

## How to Contribute

### 1. Reporting Bugs and Issues

- Before opening a new issue, please check the existing issues to see if the problem has already been reported.

- Clearly describe the issue, including steps to reproduce the bug.

- For infrastructure bugs, specify which Terraform files or AWS resources are involved.

- For application bugs, specify the relevant Next.js component or page.

### 2. Suggesting Enhancements

We're open to suggestions for new features, architectural improvements, or alternative solutions (e.g., using different AWS services).

Use the issue tracker to propose major changes. Clearly articulate the why behind the change.

### 3. Submitting Pull Requests (PRs)

1. Fork the repository and create a new branch from `main`:

  ```Bash
  git checkout -b feature/your-feature-name
  ```

2. **Make your changes**. If your PR involves infrastructure changes, run `terraform fmt` and `terraform validate` locally before committing.

3. **Test your changes**. Ensure the Next.js application still builds (npm run build) and the infrastructure plan is clean (`terraform plan`).

4. **Commit** your changes using clear and descriptive commit messages (e.g., "feat: Add DynamoDB autoscaling" or "fix: Update S3 bucket policy").

5. **Push** your branch and open a Pull Request against the `main` branch.

6. **Review**: In the PR description, reference the issue your PR addresses (if applicable, e.g., `Closes #123`).

## Infrastructure Contribution

When modifying `.tf` files:

  - **Avoid State Corruption**: Never manually edit the remote state file. All state changes must go through terraform apply.

  - **Safety First**: New infrastructure features must maintain the security posture outlined in the README.md (e.g., S3 buckets must remain private, and OAC should be utilized for CloudFront access).

  - **Variables**: Use variables defined in main.tf and variables.tf where possible, especially for region and naming conventions.

## Code of Conduct

Please note that this project is governed by the Contributor Covenant Code of Conduct. By participating, you are expected to uphold this code.
