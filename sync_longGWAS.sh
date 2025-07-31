#!/bin/bash

# Update the current main
git pull 

# List branches
git branch -a
git checkout testing # switch to testing branch

# This is to connect the forked repository to the original one (upstream)
# https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork

# Add original repository as a remote called "upstream"
git remote add upstream https://github.com/michael-ta/longitudinal-GWAS-pipeline.git

# Fetch the latest changes from latest "upstream" version
git fetch upstream

# Switch to the main branch
git checkout main

# Merge changes from upstream into the current branch
git merge upstream/main

### PUSH AND COMMIT CHANGES ###

git branch -a # List branches to confirm we are on the correct one
git checkout testing # Switch to the testing branch
git add . # Stage all changes
git commit -m "Update testing branch with latest changes from main"
# Push the changes to the remote testing branch
git push origin testing

