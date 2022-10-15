download_ohmyzsh:
  file.managed:
    - name: /opt/install.sh
    - source: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    - skip_verify: True

install_ohmyzsh:
  cmd.run:
    - name: /opt/install.sh
    - cwd: /opt/
