# Project: p-${{ values.portfolio }}-${{ values.project }}

## Configuration

- **Portfolio**: ${{ values.portfolio }}
- **Environment**: ${{ values.environment }}
- **Owner**: ${{ values.owner }}

## Namespace

Creates namespace: `p-${{ values.portfolio }}-${{ values.project }}-${{ values.environment }}`

## Location

`${{ values.portfolio }}-env/${{ values.portfolio }}-${{ values.environment }}/p-${{ values.portfolio }}-${{ values.project }}/`

## Resources

- Kubernetes namespace with labels
- Resource quota (10 CPU, 20Gi memory, 50 pods)

## Deployment

```bash
terraform init
terraform plan
terraform apply
```
