python-pip:
  pkg.installed

#upgrade lsb-release
install_lsb_release:
  pkg.installed:
    - name: lsb-release

install_gnupg:
  pkg.installed:
    - name: gnupg

upgrade_msg_pack:
  pip.installed:
    - name: msgpack-python
    - upgrade: True
    - require: 
      - pkg: python-pip

install_requests:
  pip.installed:
    - name: requests
    - upgrade: True
    - require: 
      - pkg: python-pip
