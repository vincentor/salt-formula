# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "salt/map.jinja" import salt_settings with context %}

#setup proxy
{%set idc = salt['grains.get']("idc", "")%}
{%set http_proxy=salt_settings.get("http_proxy", {}).get(idc, "") %}
{%set https_proxy=salt_settings.get("https_proxy", {}).get(idc, "")%}

{%-if http_proxy or https_proxy %}
setup_apt_proxy:
  file.managed:
    - name: /etc/apt/apt.conf.d/30aptproxy
    - template: jinja
    - source: salt://salt/files/aptproxy
    - order: 1
    - context:
      http_proxy: {{ http_proxy }}
      https_proxy: {{ https_proxy }}
{%-endif%}

install_require_pkgs:
  pkg.installed:
    - names:
      - python-apt
    - order: 1

install_pip:
  pkg.latest:
    - name: python-pip
    - order: 1

install_lsb_release:
  pkg.latest:
    - name: lsb-release
    - order: 1

install_gnupg:
  pkg.installed:
    - name: gnupg
    - order: 1

install_requests:
  pip.installed:
    - name: requests
{%- if http_proxy %}
    - proxy: {{http_proxy}}
{%-endif%}
    - require:
      - pkg: install_pip
    - order: 1

{%if idc %}
{%if http_proxy%}
http_proxy:
  environ.setenv:
    - value: {{ http_proxy }}
{%endif%}

{%if https_proxy%}
https_proxy:
  environ.setenv:
    - value: {{ https_proxy }}
{%endif%}
{%endif%}
salt-pkgrepo-install-saltstack-debian:
  pkgrepo.managed:
    - humanname: SaltStack Debian Repo
    - name: {{ salt_settings.pkgrepo }}
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: {{ salt_settings.key_url }}
    - backend: requests
    - clean_file: True
    # Order: 1 because we can't put a require_in on "pkg: salt-{master,minion}"
    # because we don't know if they are used.
    - order: 1
    - require:
      - pkg: install_require_pkgs
      - pkg: install_lsb_release
      - pkg: install_gnupg
{%-if http_proxy %}
      - environ: http_proxy
{%-endif%}
{%-if https_proxy %}
      - environ: https_proxy
{%-endif%}
