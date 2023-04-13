#!/bin/bash

read -p "Do you want to destroy tools (y/n)? " CONT
if [ "$CONT" = "y" ]; then
  echo "Approval for destroy accepted";
else
  echo "Exiting!";
  exit 1
fi

echo "Destroying tools..."
cd tools
terraform init || exit 1
terraform destroy -auto-approve || exit 1
echo "Tools destroyed"