# --------------------------------------------------
# @author David Pineda
# @email david.pineda@my.wheaton.edu
# --------------------------------------------------
# This state will ensure that ssh connections are only allowed from our ssh-gateway.

open SSH only to our predefined gateway host:
  firewalld.present:
    - name: {{ pillar['firewalld_zone'] }}
    - rich_rules:
      - rule family="ipv4" source address="{{ pillar['ssh_gateway'] }}" service name="ssh" accept

disable wide-open SSH in permanent config:
  firewalld.absent:
    - name: {{ pillar['firewalld_zone'] }}
    - prune_services
    - services: None
