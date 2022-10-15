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
  git.cloned:
    - name: https://github.com/spaceship-prompt/spaceship-prompt.git
    - target: "/usr/local/share/oh-my-zsh/custom/themes/spaceship-prompt"
  file.symlink:
    - name: /usr/local/share/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme
    - target: /usr/local/share/oh-my-zsh/custom/themes/spaceship.zsh-theme

/etc/skel/.zshrc:
  file.managed:
    - source:
      - salt://conf/zshrc-base

/root/.zshrc:
  file.managed:
    - source:
      - salt://conf/zshrc-base

/home/vhang/.zshrc:
  file.managed:
    - user: vhang
    - group: vhang
    - source:
      - salt://conf/zshrc-base
