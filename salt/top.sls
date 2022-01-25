base:
  '*':
    - pkgs.python3
  'salt7-mn':
    - ssh.gateway
  'not salt7-mn':
    - ssh.non-gateway
