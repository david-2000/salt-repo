etsencrypt:
  client:
    auth:
      method: webroot
      path: /var/www/html
      port: 80
    domain:
      {{ grains['host'] }}:
        enabled: true
	  names: 
        - {{ grains['host'}}.my.personal
