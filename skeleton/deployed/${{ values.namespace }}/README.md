# Namespace: ${{ values.namespace }}

## Configuration

- **Region**: ${{ values.region }}
- **Cluster**: ${{ values.cluster }}
- **Owner**: ${{ values.owner }}

## Deployment

This namespace was created via Harness IDP.

### Resources

- Namespace with labels
- Resource quota (10 CPU, 20Gi memory, 50 pods)

### To Deploy

```bash
terraform init
terraform plan
terraform apply
```
