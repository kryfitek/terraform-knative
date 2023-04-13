#!/bin/bash
set -e

check_dependencies() {
  echo "Checking dependencies..."
  set +e # Allow failures when checking for dependencies

  which gcloud > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install the Google Cloud CLI to continue! Exiting..."
    exit 1
  else
    echo "Google cloud CLI is installed"
  fi

  which kubectl > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install kubectl to continue! Exiting..."
    exit 1
  else
    echo "kubectl is installed"
  fi

  TF_VAR_FILE="gke/terraform.tfvars"
  if [ -f "$TF_VAR_FILE" ]; then
    echo "$TF_VAR_FILE exists"
  else 
    echo "$TF_VAR_FILE does not exist! Please create it. Exiting..."
    exit 1
  fi

  grep -i "PROJECT = " $TF_VAR_FILE > /dev/null
  if ! [[ $? -ne 1 ]]; then
    echo "Please update the '$TF_VAR_FILE' file to contain your project credentials! Exiting..."
    exit 1
  else
    echo "$TF_VAR_FILE contains project credentials"
  fi
}

create_gke () {
  set -e # Prevent any kind of script failures
  echo "Deploying GKE..."
  cd gke
  terraform init || exit 1
  terraform apply -auto-approve || exit 1
  echo -e "GKE deployed\n"
}

cli_setup () {
    echo "Configuring kubectl environment..."
    PROJECT=$(terraform output -raw project)
    REGION=$(terraform output -raw region)
    GKE_CLUSTER_NAME=$(terraform output -raw kubernetes_cluster_name)
    gcloud container clusters get-credentials $GKE_CLUSTER_NAME \
      --region $REGION --project $PROJECT
    echo -e "kubectl configured\n"
}

check_dependencies
if [ $? -eq 0 ]; then
  create_gke
  if [ $? -eq 0 ]; then
    cli_setup
  fi
fi