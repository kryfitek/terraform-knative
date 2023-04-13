# PREREQUISITES
1. gcloud CLI and gke-gcloud-auth-plugin installed
2. docker CLI installed
3. kubectl installed
4. Having a docker hub (registry) account
5. terraform CLI installed
6. Create and configure a terraform account (infra/*/versions.tf)

# BEFORE STARTING
### Create a Service Account in GCP with the following project roles:
- roles/compute.viewer (Visualizador de Compute)
- roles/compute.securityAdmin (Administrador de Seguridad de Compute)
- roles/container.admin (Administrador de Kubernetes Engine)
- roles/container.clusterAdmin (Administrador de clústeres de Kubernetes Engine)
- roles/container.developer (Desarrollador de Kubernetes Engine)
- roles/iam.serviceAccountAdmin (Administrador de cuenta de servicio)
- roles/iam.serviceAccountUser (Usuario de cuenta de servicio)
- roles/resourcemanager.projectIamAdmin (Administrador de IAM de proyecto)
- roles/compute.networkAdmin (Administrador de red de Compute)

### Activate the following APIs on the project where the Service Account was created:
- Compute Engine API - compute.googleapis.com
- Kubernetes Engine API - container.googleapis.com

### Configure gcloud (CLI) using the service account previously created
- Creates keys for service account (json file) and use it for gcloud auth:
    gcloud auth activate-service-account <account> --key-file=<json_file>

# RUNNING TERRAFORM
### Create GKE cluster
    $ cd infra
    $ ./script/build_gke.sh

### Deploy Tools (Knative and Kourier)
    $ ./script/build_tools.sh

### Deploy Services (Helloworld)
    $ ./script/build_svcs.sh