{% from "jenkins/map.jinja" import client with context %}
{%- if client.enabled %}

jenkins_client_install:
  pkg.installed:
  - names: {{ client.pkgs }}
  - order: 1

jenkins_client_dirs:
  file.directory:
  - names:
    - {{ client.dir.jenkins_source_root }}
    - {{ client.dir.jenkins_jobs_root }}
  - makedirs: true

include:
# independent statements
{%- if client.source is defined %}
  - jenkins.client.source
{%- endif %}
{%- if client.globalenvprop is defined %}
  - jenkins.client.globalenvprop
{%- endif %}
{%- if client.plugin is defined %}
  - jenkins.client.plugin
{%- endif %}
{%- if client.user is defined %}
  - jenkins.client.user
{%- endif %}
# credential statement depends only on plugin
{%- if client.credential is defined %}
  - jenkins.client.credential
{%- endif %}
# below are statements which depends on plugin and/or on credential
{%- if client.approved_scripts is defined %}
  - jenkins.client.approval
{%- endif %}
{%- if client.artifactory is defined %}
  - jenkins.client.artifactory
{%- endif %}
{%- if client.gerrit is defined %}
  - jenkins.client.gerrit
{%- endif %}
{%- if client.jira is defined %}
  - jenkins.client.jira
{%- endif %}
{%- if client.lib is defined %}
  - jenkins.client.lib
{%- endif %}
{%- if client.node is defined %}
  - jenkins.client.node
{%- endif %}
{%- if client.security is defined %}
  - jenkins.client.security
{%- endif %}
{%- if client.slack is defined %}
  - jenkins.client.slack
{%- endif %}
{%- if client.smtp is defined %}
  - jenkins.client.smtp
{%- endif %}
{%- if client.theme is defined %}
  - jenkins.client.theme
{%- endif %}
{%- if client.throttle_category is defined %}
  - jenkins.client.throttle_category
{%- endif %}
{%- if client.view is defined %}
  - jenkins.client.view
{%- endif %}

# execute job enforcements as last
{%- if client.job is defined %}
  - jenkins.client.job
{%- endif %}
{%- if client.job_template is defined %}
  - jenkins.client.job_template
{%- endif %}

{%- endif %}
