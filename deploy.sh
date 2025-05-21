#!/bin/bash

# Change to the project directory
cd /Users/ss/Documents/ctf-web

# Build MkDocs documentation
mkdocs build

# Stage all changes
git add .

# Prompt user to enter a commit message
read -p "Enter your commit message: " commit_msg

# Check if the commit message is empty
if [ -z "$commit_msg" ]; then
    echo "Commit message cannot be empty. Aborting."
    exit 1
fi

# Commit with the user's input
git commit -m "$commit_msg"

# Push to the remote main branch
git push origin main 