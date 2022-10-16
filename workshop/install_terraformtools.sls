install_terraform:
  pkgrepo.managed:
    - humanname: Hashicorp Main
    - name: deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main
    - dist: precise
    - file: /etc/apt/sources.list.d/terraform.list
    - gpgkey: https://apt.releases.hashicorp.com/gpg
    - gpgcheck: 1
    - require_in:
      - pkg: terraform
  pkg.latest:
    - name: terraform
    - refresh: True
