#!/usr/bin/env bash
set -euo pipefail

# =======================
# CONFIGURABLE VARIABLES
# =======================
RESOURCE_GROUP="rg-briana-staticweb"
LOCATION="westeurope"
STORAGE_ACCOUNT_NAME="brianacvazure01"   # nume deja setat, doar lowercase, 3-24 caractere
INDEX_FILE="index.html"

echo "=== Azure Static Website Deployment ==="

# 1. Login (doar dacă nu ești deja logată)
if ! az account show >/dev/null 2>&1; then
  echo "Logging in to Azure..."
  az login
fi

# 2. Creează Resource Group
echo "Creating resource group: $RESOURCE_GROUP ..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  >/dev/null

# 3. Creează Storage Account (tip StorageV2)
echo "Creating storage account: $STORAGE_ACCOUNT_NAME ..."
az storage account create \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --allow-blob-public-access true \
  >/dev/null

# 4. Activează Static Website
echo "Enabling static website hosting..."
az storage blob service-properties update \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --static-website \
  --index-document "$INDEX_FILE" \
  --404-document "$INDEX_FILE" \
  >/dev/null

# 5. Urcă index.html în containerul special $web
echo "Uploading $INDEX_FILE to \$web container..."
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --auth-mode login \
  --container-name "\$web" \
  --file "$INDEX_FILE" \
  --name "$INDEX_FILE" \
  --overwrite true \
  >/dev/null

# 6. Afișează URL-ul site-ului
echo
echo "✅ Deployment finished!"
echo -n "🌐 Your website URL is: "
az storage account show \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --query "primaryEndpoints.web" \
  --output tsv
echo
