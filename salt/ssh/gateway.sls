# --------------------------------------------------
# @author David Pineda
# @email david.pineda@my.wheaton.edu
# --------------------------------------------------
# This state will ensure that ssh connections are allowed from everywhere.
# Whatever host this state gets applied on can therefore serve as the gateway into
# other servers that we want to be closed off.

enable ssh access from everywhere:
  firewalld.present:
    - name: {{ pillar['firewalld_zone'] }}
    - services:
      - ssh


# This rule can also be added if we want the gateway to be accessible only from within a specific network
# close ssh acces to external ip addresses:
# -------------------------------------------------------------
  firewalld.present:
    - name: {{ pillar['firewalld_zone'] }}
    - rich_rules:
      - rule family="ipv4" source address="{{ pillar['network_range'] }}" service name="ssh" accept
  firewalld.absent:
    - name: {{ pillar['firewalld_zone'] }}
    - service:
      - ssh
