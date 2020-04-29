python-pip:
  pkg.installed

upgrade_msg_pack:
  pip.installed:
    - name: msgpack-python
    - upgrade: True
    - require: 
      - pkg: python-pip
