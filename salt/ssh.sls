{%- set tplroot = tpldir.split('/')[0] %}
{% from "salt/map.jinja" import salt_settings with context %}

{% if salt_settings.install_packages %}
ensure-salt-ssh-is-installed:
  pkg.installed:
    - pkgs:
      - {{ salt_settings.salt_minion }}{%-if salt_settings.version %}: '{{ salt_settings.version }}' {%- endif %}
{% endif %}

ensure-roster-config:
  file.managed:
    - name: {{ salt_settings.config_path }}/roster
    - source: salt://{{ tplroot }}/files/roster.jinja
    - template: jinja
{% if salt_settings.install_packages %}
    - require:
      - pkg: ensure-salt-ssh-is-installed
{% endif %}
