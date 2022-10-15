download_ohmyzsh:
  file.managed:
    - name: /opt/install.sh
    - mode: 755
    - source: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    - skip_verify: True

install_ohmyzsh:
  environ.setenv:
    - name: ZSH
    - value: /usr/local/share/oh-my-zsh
  file.absent:
    - name: /usr/local/share/oh-my-zsh
    - clean: True
  cmd.run:
    - name: /opt/install.sh
    - cwd: /opt/

/etc/skel/.zshrc:
  file.managed:
    - source:
      - salt://conf/zshrc-base
