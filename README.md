# Typescript Lambda Terraform Starter

A Typescript boilerplate starter repo for a single AWS Lambda function managed through Terraform.

## What's included

- Typescript
- ESLint, Prettier
- Terraform state on AWS S3
- Terraform deployment with an AWS S3 for the source code and a AWS Lambda with an AWS Cloudwatch log group to run the source code
- Github Workflow for running Typescript, ESLint and Prettier checks
- Github Workflow for running `terraform plan` on PRs and `terraform apply` on merge or push to main

## Prerequisites

- Node / npm
- AWS CLI
- Terraform CLI

## How to get started

1. Fork / Clone
2. Install dependencies with `npm i`.
3. Provide AWS credentials to the Github Workflow through repository environment files.
4. Add your source code to `src/`.
5. Customize `variables.tf` and `main.tf` to fit your needs.
6. Deploy by pushing / merging to main or locally by running `npm run build` and then `terraform apply`.
