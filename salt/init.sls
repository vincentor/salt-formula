# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - salt.custom
  - salt.pkgrepo
      {%- if salt['pillar.get']("salt_formulas_install", False) or salt['pillar.get']('salt_formulas:install', False) %}
  - salt.formulas
      {%- endif %}
      {%- if salt['pillar.get']("salt_master_install", False) or salt['pillar.get']('salt:master:install', False)%}
  - salt.master
  - salt.ssh
  - salt.api
  - salt.custom.clustershell
  - salt.custom.saltapi
  - salt.custom.masterdir
      {%- endif %}
      {%- if salt['pillar.get']("salt_cloud_install", False) or salt['pillar.get']('salt:cloud', False) %}
  - salt.cloud
      {%- endif %}
      {%- if salt['pillar.get']("salt_ssh_install", False) or salt['pillar.get']('salt:ssh_install', False) %}
  - salt.ssh
      {%- endif %}
      {%- if salt['pillar.get']("salt_minion_install", False) or salt['pillar.get']('salt:minion:install', False) %}
          {%- if salt['pillar.get']("salt_minion_master_type", True) or salt['pillar.get']('salt:minion:master_type', True) %}
  - salt.minion
          {%- else %}
  - salt.standalone
          {%- endif %}
      {%- endif %}
      {%- if salt['pillar.get']('salt:api:install', False) %}
  - salt.api
      {%- endif %}
      {%- if salt['pillar.get']('salt:syndic:install', False) %}
  - salt.syndic
      {%- endif %}
