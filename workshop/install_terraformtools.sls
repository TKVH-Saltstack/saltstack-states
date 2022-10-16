download_terraform:
  file.managed:
    - name: /tmp/terraform.zip
    - mode: 644
    - source: https://releases.hashicorp.com/terraform/1.3.2/terraform_1.3.2_linux_amd64.zip
    - skip_verify: True

/tmp/:
  archive.extracted:
    - source: /tmp/terraform.zip
    - use_cmd_unzip: True

install_terraform:
  file.managed:
    - name: /usr/local/bin/terraform
    - source: /tmp/terraform
    - mode: 755

cleanup_terraform:
  file.directory:
    - name: /tmp
    - clean: True
