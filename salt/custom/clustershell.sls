python-pip:
  pkg.installed

cluster_shell:
  pip.installed:
    - name: clustershell
    - upgrade: True
    - require:
      - pkg: python-pip
