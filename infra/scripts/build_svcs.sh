#!/bin/bash
set -e

check_dependencies() {
  echo "Checking dependencies..."
  set +e # Allow failures when checking for dependencies

  which kubectl > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install kubectl to continue! Exiting..."
    exit 1
  else
    echo "kubectl is installed"
  fi

  kubectl cluster-info > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please configure kubectl to continue! Exiting..."
    exit 1
  else
    echo "kubectl is configured"
  fi

  TF_VAR_FILE="tools/terraform.tfvars"
  if [ -f "$TF_VAR_FILE" ]; then
      echo "$TF_VAR_FILE exists"
  else 
      echo "$TF_VAR_FILE does not exist! Please create it and add your project credentials. Exiting..."
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

apply () {
  set -e # Prevent any kind of script failures
  echo -e "\nDeploying services..."
  cd svcs
  terraform init || exit 1
  terraform apply -auto-approve || exit 1
  echo -e "Services deployed\n"
}

success () {
  echo -e "All manifests applied successfully\n"
  HELLO_URL=$(kubectl get ksvc hello -o jsonpath="{.status.url}")
  echo -e "Helloworld URL: $HELLO_URL"
  echo -e "Done!"
}

check_dependencies
if [ $? -eq 0 ]; then
  apply
  if [ $? -eq 0 ]; then
    success
  fi
fi