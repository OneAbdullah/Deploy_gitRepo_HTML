# Bash Script: Automated Website Deployment

This Bash script is designed to automate the deployment of a website using the Apache HTTP server (`httpd`) on a Linux server. The script provides an interactive command-line interface (CLI) that allows you to specify the repository URL for your website's source code. It performs the following steps:

1. **Install httpd**: The script installs the Apache HTTP server (`httpd`) using the `yum` package manager.

2. **Enable and Start Apache2**: It enables and starts the Apache2 service to make the website accessible via a web browser.

3. **Clone the Repository**: The script clones the specified GitHub repository using `git`.

4. **Check for .htm or .html Files**: It searches for `.htm` or `.html` files in the cloned repository and, if found, allows you to select one to serve as the website's index file.

5. **Display Public IP Address**: It retrieves and displays the public IP address of the server using the `curl` command.

6. **Security Group Configuration (Optional)**: If all previous steps are successful, it provides an optional step for configuring security group rules to allow HTTP (port 80) and HTTPS (port 443) traffic.

## How to Use

1. Save the script to a file, e.g., `deploy_website.sh`.



2. Execute the script:

   ```bash
   bash /deploy_website.sh
   ```

3. Follow the interactive prompts:
   - Enter the GitHub repository URL you want to deploy.
   - Optionally, choose an HTML/HTM file to serve as the index page.

4. If all steps are successful, the script will display a success message. If not, it will indicate that the deployment failed.


## Requirements

- A Linux server with `yum` package manager.
- Internet access to download packages and the repository from GitHub.
- Appropriate permissions to install packages and configure the server.

## Disclaimer

This script is provided as-is and should be used with caution. Ensure you understand and review the script's functionality, and test it in a safe environment before deploying it to a production server.

**Use at your own risk!**
