# GCP Project: ${{ values.project_id }}

## Configuration

- **Project ID**: ${{ values.project_id }}
- **Portfolio**: ${{ values.portfolio }}
- **Environment**: ${{ values.environment }}
- **Owner**: ${{ values.owner }}

## Location

`${{ values.portfolio }}/${{ values.portfolio }}-${{ values.environment }}/${{ values.portfolio }}-${{ values.environment }}-${{ values.global_cell }}/${{ values.project_id }}/`

## Resources

- GCP Project with organizational labels
- Project managed under organization

## Deployment

```bash
terraform init
terraform plan
terraform apply
```
