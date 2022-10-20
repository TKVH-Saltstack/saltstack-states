install_kubectl_packages:
  file.managed:
    - name: /usr/local/bin/kubectl
    - mode: 755
    - source: https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl
    - skip_verify: True

{% if not salt['file.file_exists' ]('/usr/local/bin/k9s') %}

download_k9s:
  file.managed:
    - name: /tmp/k9s.tar.gz
    - mode: 644
    - source: https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_x86_64.tar.gz
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

{% endif %}

{% if not salt['file.file_exists' ]('/usr/local/bin/cilium') %}

download_cilium:
  file.managed:
    - name: /tmp/cilium.tar.gz
    - mode: 644
    - source: https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz
    - skip_verify: True
  archive.extracted:
    - name: /tmp/
    - source: /tmp/cilium.tar.gz
    - enforce_toplevel: False

install_cilium:
  file.managed:
    - name: /usr/local/bin/cilium
    - source: /tmp/cilium
    - mode: 755

cleanup_cilium:
  file.directory:
    - name: /tmp
    - clean: True

{% endif %}

{% if not salt['file.file_exists' ]('/usr/local/bin/kustomize') %}

download_kustomize:
  file.managed:
    - name: /tmp/kustomize.tar.gz
    - mode: 644
    - source: https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.7/kustomize_v4.5.7_linux_amd64.tar.gz
    - skip_verify: True
  archive.extracted:
    - name: /tmp/
    - source: /tmp/kustomize.tar.gz
    - enforce_toplevel: False

/usr/local/share/oh-my-zsh/completions:
  file.directory:
    - mode: 755
    - makedirs: True

install_kustomize:
  file.managed:
    - name: /usr/local/bin/kustomize
    - source: /tmp/kustomize
    - mode: 755
  cmd.run:
    - name: kustomize completion zsh > /usr/local/share/oh-my-zsh/completions/_kustomize
    - creates:
      - /usr/local/share/oh-my-zsh/completions/_kustomize
    - require:
      - file: install_kustomize
      - file: /usr/local/share/oh-my-zsh/completions

cleanup_kustomize:
  file.directory:
    - name: /tmp
    - clean: True

{% endif %}

kubectl_alias_k_global:
  file.append:
    - name: /etc/skel/.zshrc
    - text: |
         # kubectl
         alias k=kubectl
         source <(kubectl completion zsh)
         complete -o default -F __start_kubectl k

kubectl_alias_k_root:
  file.append:
    - name: /root/.zshrc
    - text: |
         # kubectl
         alias k=kubectl
         source <(kubectl completion zsh)
         complete -o default -F __start_kubectl k

kubectl_alias_k:
  file.append:
    - name: /home/vhang/.zshrc
    - text: |
         # kubectl
         alias k=kubectl
         source <(kubectl completion zsh)
         complete -o default -F __start_kubectl k

{% if not salt['file.file_exists' ]('/usr/local/bin/kubectx') %}

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

{% endif %}

{% if not salt['file.file_exists' ]('/usr/local/bin/kubens') %}

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

{% endif %}

kubectx_completion:
  file.managed:
    - name: /usr/local/share/oh-my-zsh/completions/_kubectx.zsh
    - mode: 755
    - source: https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh
    - skip_verify: True
    - require:
      - file: /usr/local/share/oh-my-zsh/completions

kubens_completion:
  file.managed:
    - name: /usr/local/share/oh-my-zsh/completions/_kubens.zsh
    - mode: 755
    - source: https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh
    - skip_verify: True
    - require:
      - file: /usr/local/share/oh-my-zsh/completions

kubectx_alias_global:
  file.append:
    - name: /etc/skel/.zshrc
    - text: |
        # kubectx
        alias kns=kubens
        alias kctx=kubectx

kubectx_alias_root:
  file.append:
    - name: /root/.zshrc
    - text: |
        # kubectx
        alias kns=kubens
        alias kctx=kubectx

kubectx_alias:
  file.append:
    - name: /home/vhang/.zshrc
    - text: |
        # kubectx
        alias kns=kubens
        alias kctx=kubectx
