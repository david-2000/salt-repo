# State file for seting up and configuring a docker registry server
# @author David Pineda <david.pineda@my.wheaton.edu>
# Jan 11, 2022

install docker repo:
  cmd.run:
    - name: /usr/bin/yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    - creates: /etc/yum.repos.d/docker-ce.repo

install docker packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - require:
      - install docker repo

enable and start docker service:
  service.running:
    - name: docker
    - enable: True
    - require:
      - install docker packages

# Open port 5000 (default registry port)
configure web service public zone:
  firewalld.present:
    - name: public
    - ports:
      - 5000

# This is so we can use the docker_container.running salt function
ensure the docker pip module is installed:
  pip.installed:
    - pkgs:
      - docker
