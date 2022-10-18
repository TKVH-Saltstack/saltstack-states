install_k3srequired_packages:
  pkg.installed:
    - pkgs:
      - nfs-common

/etc/rancher/k3s:
  file.directory:
    - mode: 755
    - makedirs: True

/etc/rancher/k3s/config.yaml:
  file.managed:
    - source:
      - salt://conf/k3s_config.yaml

download_k3sinstall:
  environ.setenv:
    - name: K3S_TOKEN
    - value: "12345"
  file.managed:
    - name: /opt/k3s-install.sh
    - mode: 755
    - source: https://get.k3s.io
    - skip_verify: True
  cmd.run:
    - name: /opt/k3s-install.sh
    - cwd: /opt/

k3s-server:
  service.running: []

/home/vhang/.kube:
  file.directory:
    - mode: 755
    - user: vhang
    - group: vhang
    - makedirs: True

/home/vhang/.kube/config:
  file.managed:
    - source: /etc/rancher/k3s/k3s.yaml
    - user: vhang
    - group: vhang

/root/.kube:
  file.directory:
    - mode: 755
    - makedirs: True

/root/.kube/config:
  file.managed:
    - source: /etc/rancher/k3s/k3s.yaml
    - user: root
    - group: root

