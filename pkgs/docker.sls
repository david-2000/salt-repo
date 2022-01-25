install docker repo:
  pkgrepo.managed:
    - baseurl: https://download.docker.com/linux/centos/docker-ce.repo
    - gpgcheck: 1
    - gpgkey: https://download.docker.com/linux/centos/gpg
    - enabled: True

install docker packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - require:
      - install docker repo
