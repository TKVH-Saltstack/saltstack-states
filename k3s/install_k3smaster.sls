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

/home/vhang/.kube:
  file.directory:
    - mode: 755
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

install_kubectl:
  file.managed:
    - name: /usr/local/bin/kubectl
    - mode: 755
    - source: https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl
    - skip_verify: True

download_k9s:
  file.managed:
    - name: /tmp/k9s.tar.gz
    - mode: 644
    - source: https://github.com/derailed/k9s/releases/download/v0.26.6/k9s_Linux_x86_64.tar.gz
    - skip_verify: True
  archive.extracted:
    - name: /tmp/
    - source: /tmp/k9s.tar.gz
    - enforce_toplevel: False

install_k9s:
  file.managed:
    - name: /usr/local/bin/k9s
    - source: /tmp/k9s
    - mode: 755

cleanup_k9s:
  file.directory:
    - name: /tmp
    - clean: True

kubectl_alias_k_root:
  file.append:
    - name: /root/.zshrc
    - text: 
      - "# kubectl"
      - "alias k=kubectl"
      - "source <(kubectl completion zsh)"
      - "complete -o default -F __start_kubectl k"

kubectl_alias_k:
  file.append:
   - name: /home/vhang/.zshrc
    - text:
      - "# kubectl"
      - "alias k=kubectl"
      - "source <(kubectl completion zsh)"
      - "complete -o default -F __start_kubectl k"

/usr/local/share/oh-my-zsh/completion:
  file.directory:
    - mode: 755
    - makedirs: True

download_kubectx:
  file.managed:
    - name: /tmp/kubectx.tar.gz
    - mode: 644
    - source: https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz
    - skip_verify: True
  archive.extracted:
    - name: /tmp/
    - source: /tmp/kubectx.tar.gz
    - enforce_toplevel: False
    - user: root

install_kubectx:
  file.managed:
    - name: /usr/local/bin/kubectx
    - source: /tmp/kubectx
    - mode: 755

cleanup_kubectx:
  file.directory:
    - name: /tmp
    - clean: True

download_kubens:
  file.managed:
    - name: /tmp/kubens.tar.gz
    - mode: 644
    - source: https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz
    - skip_verify: True
  archive.extracted:
    - name: /tmp/
    - source: /tmp/kubens.tar.gz
    - enforce_toplevel: False
    - user: root

install_kubens:
  file.managed:
    - name: /usr/local/bin/kubens
    - source: /tmp/kubens
    - mode: 755

cleanup_kubens:
  file.directory:
    - name: /tmp
    - clean: True

kubectx_completion:
  file.managed:
    - name: /usr/local/share/oh-my-zsh/completion/_kubectx.zsh
    - mode: 755
    - source: https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh
    - skip_verify: True

kubens_completion:
  file.managed:
    - name: /usr/local/share/oh-my-zsh/completion/_kubens.zsh
    - mode: 755
    - source: https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh
    - skip_verify: True

kubectx_alias:
  file.append:
    - name: /home/vhang/.zshrc
    - text:
      - "# kubectx"
      - "alias kns=kubens"
      - "alias kctx=kubectx"
      - "complete -o default -F __start_kubens kns"
      - "complete -o default -F __start_kubectx kctx"

kubectx_alias_root:
  file.append:
    - name: /root/.zshrc
    - text:
      - "# kubectx"
      - "alias kns=kubens"
      - "alias kctx=kubectx"
      - "complete -o default -F __start_kubens kns"
      - "complete -o default -F __start_kubectx kctx"
