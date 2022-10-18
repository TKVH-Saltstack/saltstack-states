install_k3srequired_packages:
  pkg.installed:
    - pkgs:
      - nfs-common

K3STOKEN_env:
  environ.setenv:
    - name: K3S_TOKEN
    - value: "12345"

K3SURL_env:
  environ.setenv:
    - name: K3S_URL
    - value: "https://k3s-prod-master01:6443"

download_k3sinstall:
  file.managed:
    - name: /opt/k3s-install.sh
    - mode: 755
    - source: https://get.k3s.io
    - skip_verify: True
  cmd.run:
    - name: /opt/k3s-install.sh
    - cwd: /opt/
  service.running:
    - name: k3s-agent
