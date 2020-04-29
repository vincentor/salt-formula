# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "salt/map.jinja" import salt_settings with context %}

  {%- if salt_settings.pkgrepo %}

{%- if salt_settings.get('repomgr', '') %}
install_require_pkgs:
  pkg.installed:
    - names:
      - python-apt
{%- endif %}

include:
  - .{{ grains['os_family']|lower }}

  {%- endif %}
