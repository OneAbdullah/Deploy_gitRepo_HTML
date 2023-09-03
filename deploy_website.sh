#!/bin/bash

while true; do
    # Interactive CLI
    read -p "Enter the repository URL (or 'exit' to quit): " repo_url
    if [ "$repo_url" == "exit" ]; then
        break
    fi

    
    echo "Kindly ensure that both HTTP and HTTPS are enabled in the security group settings"
    
    # Variables
    web_dir="/var/www/html"
    httpd_installed=false
    httpd_service_status=""
    repo_cloned=false
    html_found=false
    pip_installed=false

    # Function to check if a command was successful
    check_success() {
        if [ $? -eq 0 ]; then
            echo "Success"
        else
            echo "Failed"
            exit 1
        fi
    }
    # Install httpd
    echo "Installing httpd..."
    yum install -y httpd
    check_success
    httpd_installed=true

    # Install httpd
    echo "Installing pip..."
    yum install -y pip
    check_success
    pip_installed=true


    # Enable and start Apache2
    echo "Enabling and starting Apache2..."
    systemctl enable httpd
    systemctl start httpd
    check_success
    httpd_service_status=$(systemctl is-active httpd)

    # Clone the repository from GitHub
    echo "Cloning the repository from GitHub..."
    wget -q -N "$repo_url"
    check_success
    repo_cloned=true

    # Check for .htm or .html files
    echo "Checking for .htm or .html files..."
html_files=$(find . -type f ( -name ".htm" -o -name ".html" ))
if [ -n "$html_files" ]; then
    html_found=true
    echo "Found the following HTML/HTM files:"
    select file in $html_files; do
        mv "$file" "$web_dir/index.html"
        check_success
        break
    done
else
    echo "No .htm or .html files found."
fi

    # Print the public IP address of the server
    public_ip=$(curl -s https://ipinfo.io/ip)
    echo "Public IP address of the server: $public_ip"

    # Check if each step was successful
    echo "Step 1: Install httpd - $httpd_installed"
    echo "Step 2: Enable and start Apache2 - $httpd_service_status"
    echo "Step 3: Clone the repository from GitHub - $repo_cloned"
    echo "Step 4: Check for .htm or .html files - $html_found"

    # Print a final message
    if [ "$httpd_installed" = true ] && [ "$httpd_service_status" = "active" ] && [ "$repo_cloned" = true ] && ["$pip_installed" = true]; then
        echo "Website deployment successful!"


    else
        echo "Website deployment failed."
    fi
done
