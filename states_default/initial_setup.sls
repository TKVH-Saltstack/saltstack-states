install_network_packages:
  pkg.installed:
    - pkgs:
      - vim
      - zsh
      - git
      - neofetch
      - fonts-firacode
      - fonts-powerline
      - curl
      - unzip

/etc/ssh/sshd_config:
  file.managed:
    - source:
      - salt://conf/sshd_config

vhang:
  user.present:
    - fullname: Victor HANG
    - shell: /bin/zsh
    - groups: 
      - sudo

root:
  user.present:
    - shell: /bin/zsh

download_ohmyzsh:
  file.managed:
    - name: /opt/install.sh
    - mode: 755
    - source: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    - skip_verify: True

{% if not salt['file.directory_exists' ]('/usr/local/share/oh-my-zsh') %}

install_ohmyzsh:
  environ.setenv:
    - name: ZSH
      - value: /usr/local/share/oh-my-zsh
    - name: KEEP_ZSHRC
      - value: yes

  file.absent:
    - name: /usr/local/share/oh-my-zsh
    - clean: True
  cmd.run:
    - name: /opt/install.sh
    - cwd: /opt/
  git.cloned:
    - name: https://github.com/spaceship-prompt/spaceship-prompt.git
    - target: "/usr/local/share/oh-my-zsh/custom/themes/spaceship-prompt"

/usr/local/share/oh-my-zsh/custom/themes/spaceship.zsh-theme:
  file.symlink:
    - target: /usr/local/share/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh

{% endif %}

/etc/skel/.zshrc:
  file.append:
    - text: |
        # oh-my-zsh
        ZSH="/usr/local/share/oh-my-zsh"
        ZSH_THEME="spaceship"
        DISABLE_AUTO_UPDATE="true"
        DISABLE_MAGIC_FUNCTIONS="true"
        DISABLE_AUTO_TITLE="true"
        ENABLE_CORRECTION="true"
        plugins=(git)
        export EDITOR='vim'
        ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
        if [[ ! -d $ZSH_CACHE_DIR ]]; then
          mkdir -p $ZSH_CACHE_DIR
        fi
        source $ZSH/oh-my-zsh.sh
        # spaceship zsh theme
        SPACESHIP_DIR_TRUNC=0
        SPACESHIP_TIME_SHOW=true
        SPACESHIP_USER_SHOW=always
        SPACESHIP_KUBECTL_SHOW=true
        # Misc
        export LC_ALL=$LANG
        alias ll="ls -hlt"
        alias l="ls -halt"
        neofetch

/home/vhang/.zshrc:
  file.append:
    - sources:
      - /etc/skel/.zshrc

/root/.zshrc:
  file.append:
    - sources:
      - /etc/skel/.zshrc

update_pkg:
  pkg.uptodate:
    - refresh : True
