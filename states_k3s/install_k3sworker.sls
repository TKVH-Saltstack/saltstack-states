install_k3srequired_packages:
  pkg.installed:
    - pkgs:
      - nfs-common

K3STOKEN_env:
  environ.setenv:
    - name: K3S_TOKEN
    - value: "K1015f37e9f2706e126d361372093d914da54e101119c55f52d5e68256788ae1b15::server:abe954d0a445407e9b292a55e1472499"

K3SURL_env:
  environ.setenv:
    - name: K3S_URL
    - value: "https://192.168.1.2:6443"

download_k3sinstall:
  file.managed:
    - name: /opt/k3s-install.sh
    - mode: 755
    - source: https://get.k3s.io
    - skip_verify: True
  cmd.script:
    - name: k3s-install.sh
    - source: /opt/k3s-install.sh
  service.running:
    - name: k3s-agent
