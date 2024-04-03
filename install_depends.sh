#!/bin/bash

# This script installs dependencies from a "depends" file
# Sometimes, dependencies are given in the form of "package: dependency", 
# where "package" depends on "dependency". This script reads the file and
# installs the dependencies accordingly. apt-get on its own doesn't support
# this kind of dependency resolution.

# Function to install dependencies
install_dependencies() {
    # Declare an array to hold package names
    packages=()

    # Read the dependency file and populate the array
    while IFS=: read -r package dependency; do
        # If there's a colon in the line, add dependency to packages array
        if [[ -n $dependency ]]; then
            packages+=("$dependency")
        else
            packages+=("$package")
        fi
    done < "$1"

    # Install all packages using apt-get install
    sudo apt-get install -y "${packages[@]}"
}

# Usage: install_dependencies <dependency_file>
sudo apt-get update
install_dependencies "$1"
