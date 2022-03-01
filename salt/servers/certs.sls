
{{ grains['host'] }}:
  acme.cert:
    - aliases:
      - {{ grains['host'] }}.david.pineda
    - email: davidalexpineda@gmail.com
    - renew: 5
    - webroot: /usr/share/httpd/noindex/
