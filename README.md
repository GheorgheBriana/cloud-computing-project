# Homework 1 – Static Web Page on Azure Storage

**Name:** Gheorghe Briana-Maria  

**URL:** `https://brianacvazure01.z6.web.core.windows.net/`  

**Description:**  
This is a personal CV / portfolio page built as a single static HTML file and hosted on Azure Storage as a static website.  
The page presents my background as a Master's student in Databases and Software Technologies, my main software projects
(Java, Spring Boot, Android, Oracle PL/SQL), education, trainings, and technical skills.

**How it was deployed (short):**
- The `deploy.sh` script creates an Azure Resource Group and a Storage Account (StorageV2).
- Static website hosting is enabled on the storage account, with `index.html` as the default document.
- The script uploads `index.html` to the special `$web` container.
- At the end, the script prints the public URL of the website.
