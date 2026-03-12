# Quick Setup Guide

## Step 1: Create GitHub Repo

Create a new repo on GitHub (or GitHub Enterprise):
- Name: `namespace-template` (or whatever you prefer)
- Visibility: Private or Public
- Don't initialize with README (we have files already)

## Step 2: Push This Template

```bash
cd /Users/rashmihegde/harness-idp-demo/template-repo

# Initialize git
git init
git add .
git commit -m "Initial namespace template"

# Add your GitHub repo
git remote add origin git@github.com:yourorg/namespace-template.git

# Push
git branch -M main
git push -u origin main
```

## Step 3: Register in Harness IDP

1. Open Harness IDP
2. Go to **Create** → **Register Software Template**
3. Enter URL:
   ```
   https://github.com/yourorg/namespace-template/blob/main/catalog-info.yaml
   ```
4. Click **Import**

## Step 4: Configure Target Repo

Edit `catalog-info.yaml` line 58:

```yaml
# Change this:
repoUrl: github.com?owner=yourorg&repo=infrastructure

# To your actual infrastructure repo:
repoUrl: github.com?owner=paypal&repo=infrastructure-configs
```

## Step 5: Test It

1. Go to Harness IDP
2. Click **Create**
3. Select **"Create Kubernetes Namespace"**
4. Fill the form:
   - Namespace: `test-demo`
   - Region: `us-central1`
   - Cluster: `your-cluster-name`
   - Owner: `your-username`
5. Click **Create**

A PR will be created in your infrastructure repo!

## What You Get

After running the template, in your infrastructure repo:

```
infrastructure-repo/
└── deployed/
    └── test-demo/           # Your namespace
        ├── main.tf          # Creates namespace + quota
        ├── variables.tf     # Variables
        ├── terraform.tfvars # Values
        └── README.md        # Docs
```

Then merge the PR and run your pipeline to deploy!
