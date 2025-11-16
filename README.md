# Homework Cloud Computing – Static Web Page on Azure Storage

**Name:** Gheorghe Briana-Maria  

**URL:** `https://brianacvazure01.z6.web.core.windows.net/`  

**Description:**  
This is a personal CV / portfolio page built as a single static HTML file and hosted on Azure Storage as a static website.  

**How it was deployed:**
- The `deploy.sh` script creates an Azure Resource Group and a Storage Account (StorageV2).
- Static website hosting is enabled on the storage account, with `index.html` as the default document.
- The script uploads `index.html` to the special `$web` container.
- At the end, the script prints the public URL of the website.

