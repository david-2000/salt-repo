install python3:
  pkg.installed:
    - pkgs:
      - python3
      - python3-devel

setup a system-wide virtual-env to install pip packages in:
  virtualenv.managed:
    - name: /usr/local/python3_env
    - python: /usr/bin/python3
    - user: root
    - require:
      - pkg: install python3

ensure that virtualenv is in system PATH:
  file.managed:
    - name: /etc/profile.d/python3_env.sh
    - contents: |
        export PATH=/usr/local/python3_env/bin:$PATH
    - require:
      - pip: setup a system-wide virtual-env to install pip packages in


install useful python packages in virtualenv:
  pip.installed:
    - bin_env: /usr/local/python3_env/bin/pip3
    - pkgs:
      - pytest
