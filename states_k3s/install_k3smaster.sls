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
    - require:
      - file: /etc/rancher/k3s

download_k3sinstall:
  environ.setenv:
    - name: K3S_TOKEN
    - value: "12345"
  file.managed:
    - name: /opt/k3s-install.sh
    - mode: 755
    - source: https://get.k3s.io
    - skip_verify: True

install_k3s:
  cmd.script:
    - name: k3s-install.sh
    - source: /opt/k3s-install.sh
    - stateful: True
  service.running:
    - name: k3s

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
    - require:
      - service: install_k3s

/root/.kube:
  file.directory:
    - mode: 755
    - makedirs: True

/root/.kube/config:
  file.managed:
    - source: /etc/rancher/k3s/k3s.yaml
    - user: root
    - group: root
    - require:
      - service: install_k3s
