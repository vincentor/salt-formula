saltapi_user:
  user.present:
    - name: {{ salt["pillar.get"]("salt:saltapi_user", "salt")}}
    - fullname: salt api
    - shell: /bin/bash
    - password: {{ salt["pillar.get"]("salt:saltapi_passwd")}}
