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
  cmd.script:
    - name: k3s-install.sh
    - source: /opt/k3s-install.sh
    - stateful: True
    - success_stdout: 
      - "[INFO]  systemd: Starting k3s"

k3s:
  service.running:
    - require:
      - cmd: download_k3sintall

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
      - cmd: download_k3sintall

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
      - cmd: download_k3sintall
