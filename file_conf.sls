download_ohmyzsh:
  file.managed:
    - name: /opt/install.sh
    - mode: 755
    - source: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    - skip_verify: True

preinstall_ohmyzsh:
   environ.setenv:
     - name: ZSH
     - value: /usr/local/share/oh-my-zsh

install_ohmyzsh:
  cmd.run:
    - name: /opt/install.sh
    - cwd: /opt/
    - onlyif:
      - test -d /usr/local/share/oh-my-zsh && echo 1
/etc/skel/.zshrc:
  file.managed:
    - source:
      - salt://conf/zshrc-base
