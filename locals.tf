locals {
  gitlab_credentials = jsondecode(
     file("${path.module}/.vars")
  )
}
