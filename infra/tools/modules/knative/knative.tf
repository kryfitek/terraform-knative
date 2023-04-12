data "kubectl_file_documents" "crds" {
  content = file("${path.root}/manifests/knative/serving-crds.yaml")
}

resource "kubectl_manifest" "knative_crds" {
  count = length(data.kubectl_file_documents.crds.documents)  
  yaml_body = element(data.kubectl_file_documents.crds.documents, count.index)
}

data "kubectl_file_documents" "core" {
  content = file("${path.root}/manifests/knative/serving-core.yaml")
}

resource "kubectl_manifest" "knative_serving" {
  count = length(data.kubectl_file_documents.core.documents)  
  yaml_body = element(data.kubectl_file_documents.core.documents, count.index)
}

data "kubectl_file_documents" "kourier" {
  content = file("${path.root}/manifests/knative/kourier.yaml")
}

resource "kubectl_manifest" "kourier_ingress" {
  count = length(data.kubectl_file_documents.kourier.documents)  
  yaml_body = element(data.kubectl_file_documents.kourier.documents, count.index)
}