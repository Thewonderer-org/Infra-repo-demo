# Infrastructure Repository

This repo contains:
- Infrastructure code organized by portfolio and environment
- Template files in `skeleton/` for creating new projects

## Structure

```
Infra-repo-demo/
├── skeleton/                          # Templates (used by pipeline)
│   └── deployed/
│       └── ${{ values.namespace }}/
│           ├── main.tf
│           ├── variables.tf
│           └── README.md
│
├── checkout-env/                      # Checkout portfolio
│   ├── checkout-dev/
│   │   └── p-checkout-compute/        # Created by pipeline
│   └── checkout-prod/
│
└── payments-env/                      # Payments portfolio
    ├── payments-dev/
    └── payments-prod/
```

## How It Works

1. Developer fills form in Harness IDP
2. IDP triggers pipeline with parameters
3. Pipeline copies `skeleton/` → `{portfolio}-env/{portfolio}-{env}/p-{portfolio}-{project}/`
4. Pipeline replaces `${{ values.* }}` with actual values
5. Pipeline creates PR
6. After merge, pipeline deploys namespace

## Created By

Harness IDP Pipeline-driven workflow

test minor
