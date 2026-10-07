# La Bodega 2.0 - Infra

Terraform infrastructure for La Bodega 2.0, deployed on AWS. This repo provisions the VPC, database, serverless API, static frontend, and the TLS certificates/domains that tie them together.

## Architecture

- **VPC** - private/public subnets across two AZs (`modules/stacks/vpc`, backed by `terraform-aws-modules/vpc/aws`).
- **Database** - MySQL on RDS inside the private subnets (`modules/stacks/database`).
- **Backend** - API Gateway (HTTP API) + Lambda functions for auth, categories, and accounts, plus a bastion EC2 instance for access into the VPC (`modules/stacks/backend`).
- **Frontend** - static site in an S3 bucket served through CloudFront via Origin Access Control (`modules/stacks/frontend`).
- **Certificates** - ACM certificates for the API custom domain (regional, `us-west-2`) and the frontend custom domain (CloudFront, `us-east-1`) (`dev/certificates/*`).
- **Remote state** - all stacks store state in a shared, versioned, encrypted S3 bucket (`global/s3`), with S3-native state locking (`use_lockfile`).

Stacks communicate via Terraform remote state data sources (e.g. the backend stack reads VPC, RDS, and certificate outputs) rather than being applied as one root module.

## Repository layout

```
dev/                      Per-environment root modules (currently: dev)
  vpc/                    VPC
  database/               RDS
  certificates/
    regional/             ACM cert for the API domain (us-west-2)
    cloudfront/           ACM cert for the frontend domain (us-east-1)
  backend/                API Gateway + Lambda + bastion EC2
  frontend/               S3 + CloudFront static site
global/
  s3/                     Shared Terraform state bucket (bootstrap, applied once)
modules/
  stacks/                 Composed stacks used by the dev/* root modules
  services/               Reusable building blocks (ec2, rds, lambda, api_gateway, cloudfront)
```

## Prerequisites

- Terraform `>= 1.2`
- AWS provider `~> 5.92`
- AWS credentials with permissions for the resources above (`aws configure`, or `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` env vars)
- Sibling repos checked out next to this one, since `backend` and `frontend` reference build artifacts by relative path:
  - `../La-Bodega-2.0-API/dist/functions` (Lambda bundles)
  - `../La-Bodega-2.0-Frontend/dist` (static site build)

## Deployment order

The state bucket must exist first; after that, stacks depend on each other's outputs, so apply in this order:

1. `global/s3` - one-time bootstrap of the remote state bucket
2. `dev/vpc`
3. `dev/database`
4. `dev/certificates/regional` and `dev/certificates/cloudfront` (validate the DNS records ACM requests before moving on)
5. `dev/backend` - requires `jwt_key` and `mysql_password` variables
6. `dev/frontend` - requires the frontend build to already exist at `../La-Bodega-2.0-Frontend/dist`

For each stack:

```bash
cd dev/<stack>
terraform init
terraform plan
terraform apply
```

Sensitive variables (`jwt_key`, `mysql_password`, `db_password`) are not stored in the repo - pass them via `TF_VAR_*` environment variables or a local `*.tfvars` file that is not committed.

## Notes

- All resources are tagged/named with the `labodega-dev` identifier; adding another environment means adding a new folder under `dev/` (or promoting it to `prod/`) that points at new remote state keys.
- `.gitignore` excludes `.terraform`, `*.tfstate*`, and `*.zip` (Lambda bundles) - these are generated locally or produced by the API build.

## Pending

- Add Lambda layers (shared dependencies instead of bundling them into every function zip).
- Switch RDS to native/managed password authentication instead of a plain `db_password` variable.
- Enable RDS automated backups.
- Store Lambda deployment packages in S3 instead of uploading the zip directly.
- Sort/clean up the Terraform code.
