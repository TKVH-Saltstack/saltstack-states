install_network_packages:
  pkg.installed:
    - pkgs:
      - sudo
      - vim
      - nfs-common
      - zsh
      - openssh-server
      - cloud-init
      - curl
      - git
