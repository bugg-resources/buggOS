#!/bin/bash

# This script installs dependencies from a "depends" file
# Sometimes, dependencies are given in the form of "package: dependency", 
# where "package" depends on "dependency". This script reads the file and
# installs the dependencies accordingly. apt-get on its own doesn't support
# this kind of dependency resolution.

install_dependencies() {
    # Read the dependency file and install dependencies
    while IFS=: read -r package dependency; do
        # If there's a colon in the line
        if [[ -n $dependency ]]; then
            echo "Installing $dependency"
            sudo apt-get install -y "$dependency"
        else
            echo "Installing $package"
            sudo apt-get install -y "$package"
        fi
    done < "$1"
}

# Usage: install_dependencies <dependency_file>
sudo apt-get update
install_dependencies "$1"
