data "kubectl_file_documents" "operator" {
  content = file("${path.root}/manifests/helloworld/helloworld.yaml")
}

resource "kubectl_manifest" "knative_operator" {
  count = length(data.kubectl_file_documents.operator.documents)  
  yaml_body = element(data.kubectl_file_documents.operator.documents, count.index)
}