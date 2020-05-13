python-pip:
  pkg.installed

install_gnupg:
  pkg.installed:
    - name: gnupg

upgrade_msg_pack:
  pip.installed:
    - name: msgpack-python
    - upgrade: True
    - require: 
      - pkg: python-pip
