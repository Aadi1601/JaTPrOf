#!/bin/bash

# Run the setup script
./setup_script.sh

# Check if the setup script exited successfully
if [ $? -eq 0 ]; then
    echo "Setup completed successfully."
else
    echo "Setup failed. Please check the errors and try again."
    exit 1
fi

# Check for common errors in the setup script
if grep -q "error" setup_script.sh; then
    echo "Errors found in setup script. Please check the script and try again."
    exit 1
fi

# Check for package installation errors
if grep -q "Error" setup_script.sh; then
    echo "Package installation errors found. Please check the script and try again."
    exit 1
fi

# Check for missing dependencies
if grep -q "not found" setup_script.sh; then
    echo "Missing dependencies found. Please check the script and try again."
    exit 1
fi

# Check for other common errors
if grep -q "unable to resolve host" setup_script.sh; then
    echo "Unable to resolve host error found. Please check your network connection and try again."
    exit 1
fi

echo "Setup completed successfully."
