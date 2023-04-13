#!/bin/bash

read -p "Do you want to completly destroy your K8s cluster (y/n)? " CONT
if [ "$CONT" = "y" ]; then
  echo "Approval for destroy accepted";
else
  echo "Exiting!";
  exit 1
fi

echo "Destroying GKE..."
cd gke
terraform init || exit 1
terraform destroy -auto-approve || exit 1
echo -e "GKE destroyed\n"