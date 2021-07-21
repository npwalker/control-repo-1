# Example of a module from an internal repo co-existing with forge modules.
#mod 'splunk',
#  :git => 'https://internal.git.server/example/puppet-splunk.git',
#  :commit => '3ca47046a86aef9fbfdf58cc7b418d8e7254ecb9'

if ENV['ADD_SUPPORTED_MODULES'] != 'false'
    mod 'puppetlabs-dsc'
    mod 'puppetlabs-dsc_lite'
    mod "puppetlabs/vcsrepo"
    mod "puppetlabs/apt"
    mod "puppetlabs/firewall"
    mod "puppetlabs/postgresql"
    mod "puppetlabs/ntp"
    mod "puppetlabs/mysql"
    mod "puppetlabs/java"
    mod "puppetlabs/java_ks"
    mod "puppetlabs/registry"
    mod "puppetlabs-pwshlib"
    mod "puppetlabs/powershell"
    mod "puppetlabs/tomcat"
    mod "puppetlabs/reboot"
    mod "puppetlabs/acl"
  end
  
  if ENV['ADD_APPROVED_MODULES'] != 'false'
    mod "maestrodev/wget"
    mod "stahnma/epel"
    mod "nanliu/staging"
    mod "stankevich/python"
    mod "garethr/erlang"
    mod "elasticsearch/elasticsearch"
    mod "garethr/docker"
    mod "saz/rsyslog"
    mod "rtyler/jenkins"
    mod "rodjek/logrotate"
    mod "sensu/sensu"
    mod "camptocamp/openssl"
    mod "openshift/openshift_origin"
    mod "herculesteam/augeasproviders_core"
    mod "mayflower/php"
    mod "razorsedge/vmwaretools"
    mod "arioch/keepalived"
    mod "fsalum/newrelic"
    mod "badgerious/windows_env"
    mod "wdijkerman/zabbix"
    mod "ghoneycutt/dnsclient"
    mod "herculesteam/augeasproviders_shellvar"
    mod "camptocamp/kmod"
    mod "herculesteam/augeasproviders_ssh"
    mod "trlinkin/nsswitch"
    mod "razorsedge/cloudera"
    mod "cyberious/pget"
    mod "opentable/windowsfeature"
    mod "danzilio/virtualbox"
    mod "KyleAnderson/consul"
    mod "herculesteam/augeasproviders_sysctl"
    mod "example42/network"
    mod "jhoblitt/ganglia"
    mod "golja/gnupg"
    mod "herculesteam/augeasproviders_postgresql"
    mod "ghoneycutt/pam"
    mod "herculesteam/augeasproviders_base"
    mod "herculesteam/augeasproviders_pam"
    mod "jhoblitt/selenium"
    mod "mkrakowitzer/jira"
    mod "stackforge/keystone"
    mod "herculesteam/augeasproviders_grub"
    mod "herculesteam/augeasproviders_nagios"
    mod "herculesteam/augeasproviders"
    mod "herculesteam/augeasproviders_apache"
    mod "herculesteam/augeasproviders_puppet"
    mod "herculesteam/augeasproviders_syslog"
    mod "herculesteam/augeasproviders_mounttab"
    mod "mukaibot/bamboo"
    mod "puppet/stash"
    mod "puppet/iis"
  end
  
  mod 'npwalker/pe_metric_curl_cron_jobs'
  
  # Always pull swap_file for managing swap space
  mod 'petems/swap_file'
  mod 'fiddyspence/sysctl'
  
  # Always pull hosts for managing /etc/hosts
  mod "ghoneycutt/hosts"
  
  # Always pull the latest clamps module code
  mod 'clamps',
    :git => 'https://github.com/puppetlabs/clamps.git'
  
  # Clamps' hiera support is configured using this module
  mod 'hiera',
    :git => 'https://github.com/hunner/puppet-hiera.git',
    :tag => '1.2.0'
  
  # Modules required for graphite/grafana installation on the 'metrics' host
  mod "dwerder/graphite" ,'5.16.1'
  mod "dwerder/grafana"  ,'1.2.0'
  
  # Modules required for LDAP integration.
  # This is an approved module
  mod 'camptocamp-openldap',
    :git => 'https://github.com/camptocamp/puppet-openldap.git',
    :ref => '1.6.1'
  
  # The following are already approved / supported modules, but because they are
  # specific to our code, pin the exact version we want
  mod 'haproxy',
    :git => 'https://github.com/puppetlabs/puppetlabs-haproxy.git',
    :ref => '1.0.0'
  mod 'concat',
    :git => 'https://github.com/puppetlabs/puppetlabs-concat.git',
    :ref => '1.1.1'
  mod 'stdlib',
    :git => 'https://github.com/puppetlabs/puppetlabs-stdlib.git',
    :ref => '4.13.1'
  mod 'apache',
    :git => 'https://github.com/puppetlabs/puppetlabs-apache.git',
    :ref => '1.5.0'
  mod 'inifile',
    :git => 'https://github.com/puppetlabs/puppetlabs-inifile.git',
    :ref => 'main'
  mod 'collectd',
    :git => 'https://github.com/pdxcat/puppet-module-collectd.git',
    :ref => 'v3.4.0'
