data "kubectl_file_documents" "operator" {
  content = file("${path.root}/manifests/knative/operator.yaml")
}

resource "kubectl_manifest" "knative_operator" {
  count = length(data.kubectl_file_documents.operator.documents)  
  yaml_body = element(data.kubectl_file_documents.operator.documents, count.index)
}

data "kubectl_file_documents" "serving" {
  content = file("${path.root}/manifests/knative/serving.yaml")
}

resource "kubectl_manifest" "knative_serving" {
  count = length(data.kubectl_file_documents.serving.documents)  
  yaml_body = element(data.kubectl_file_documents.serving.documents, count.index)
  depends_on = [
    data.kubectl_file_documents.operator
  ]
}