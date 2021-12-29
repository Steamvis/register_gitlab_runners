resource "local_file" "ansible_hosts_file" {
  content    = <<-EOT
[dev]
${google_compute_instance.dev.network_interface.0.access_config.0.nat_ip}
[prod]
${google_compute_instance.prod.network_interface.0.access_config.0.nat_ip}
[builder]
${google_compute_instance.builder.network_interface.0.access_config.0.nat_ip}
  EOT
  filename   = "${path.module}/ansible/hosts"
  depends_on = [google_compute_instance.builder, google_compute_instance.dev, google_compute_instance.prod]
}

resource "null_resource" "run_ansible" {
  depends_on = [local_file.ansible_hosts_file]
  provisioner "local-exec" {
    command = <<-EOT
export ANSIBLE_HOST_KEY_CHECKING=False;
ansible-playbook ${path.module}/ansible/playbook.yaml -i ${path.module}/ansible/hosts \
-e remote_user=${var.remote_user} \
-e gitlab_api_token=${local.gitlab_credentials["gitlab_api_token"]} \
-e gitlab_runner_token=${local.gitlab_credentials["gitlab_runner_token"]}
    EOT
  }
}