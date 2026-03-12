# Harness IDP Template - Namespace Provisioning

This is the template repository for creating Kubernetes namespaces via Harness IDP.

## What This Template Does

When a developer uses this template in Harness IDP:
1. They fill out a simple form (namespace, region, cluster, owner)
2. This template generates Terraform configuration
3. A PR is created in your infrastructure repo
4. After merge, the namespace is deployed

## Template Structure

```
template-repo/
├── catalog-info.yaml          # IDP workflow definition
└── skeleton/                  # Template files
    └── deployed/
        └── ${{ values.namespace }}/
            ├── main.tf        # Terraform config
            ├── variables.tf   # Variables
            ├── terraform.tfvars  # Values
            └── README.md      # Documentation
```

## Setup in Harness IDP

1. **Create this repo on GitHub**
   ```bash
   # Upload these files to: github.com/yourorg/namespace-template
   ```

2. **Register in Harness IDP**
   - Go to IDP → Create → Register Software Template
   - Enter URL: `https://github.com/yourorg/namespace-template/blob/main/catalog-info.yaml`

3. **Configure target repo**
   - Edit `catalog-info.yaml` line 58
   - Change `yourorg/infrastructure` to your actual infrastructure repo

4. **Test it**
   - Go to IDP → Create → "Create Kubernetes Namespace"
   - Fill the form
   - Submit

## What Gets Generated

For a namespace called `my-app`:

```
infrastructure-repo/
└── deployed/
    └── my-app/
        ├── main.tf           # Creates namespace + quota
        ├── variables.tf      # Variable definitions
        ├── terraform.tfvars  # Actual values
        └── README.md         # Documentation
```

## Next Steps

After the template is working:
- Add pipeline to auto-deploy on PR merge
- Add validation steps
- Add more resources (secrets, configmaps, etc.)
