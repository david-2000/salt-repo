## State for starting and maintaining the docker-registry server.
# @author David Pineda <david.pineda@my.wheaton.edu>
# Jan 25, 2022
# Looking at https://docs.saltproject.io/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.running
# for reference on how to use the docker salt states

# This folder will hold the hostname.key and hostname.crt certificate files
# These must be manually configured before running this state. Simply placing them in /etc/docker-registry-config/certs will suffice
/etc/docker-compose/certs:
  file.directory:
    - user: root
    - file_mode: 640
    - dir_mode: 750
    - makedirs: True

# This folder will hold the htpasswd file containing the basic authentication parameters for the registry.
# These must be manually configured before running this state. Simply placing them in /etc/docker-registry-config/auth will suffice
/etc/docker-compose/auth:
  file.directory:
    - user: root
    - file_mode: 640
    - dir_mode: 750
    - makedirs: True

run the docker-registry container:
  docker_container.running:
    - name: docker-repo-t1.wheaton.edu
    - image: registry:2
    - restart_policy: unless-stopped
    - ports:
      - 5000
    - port_bindings:
      - 5000:5000
    - environment:
      - REGISTRY_HTTP_TLS_CERTIFICATE: /certs/{{ grains['host'] }}.crt
      - REGISTRY_HTTP_TLS_KEY: /certs/{{ grains['host'] }}.key
      - REGISTRY_AUTH: htpasswd
      - REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      - REGISTRY_AUTH_HTPASSWD_REALM: Wheaton Realm
    - binds:
      - /mnt/registry:/var/lib/registry
      - /etc/docker-compose/certs:/certs
      - /etc/docker-compose/auth:/auth
    - require:
      - pip: ensure the docker pip module is installed
