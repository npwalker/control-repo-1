## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
#https://docs.puppet.com/pe/2015.3/release_notes.html#filebucket-resource-no-longer-created-by-default
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

node 'agent-to-puppet-enterprise-master.puppetdebug.vlan' {
  class { 'hdp::app_stack':
        ca_server        => 'https://puppet-enterprise-master.puppetdebug.vlan:8140',
        dns_name         => 'agent-to-puppet-enterprise-master.puppetdebug.vlan',
        image_repository => 'gcr.io/hdp-gcp-316600',
        hdp_version      => 'latest',
        ui_use_tls       => true,
        ui_key_file      => "${::settings::privatekeydir}/${::trusted['certname']}.pem",
        ui_cert_file     => "${::settings::certdir}/${::trusted['certname']}.pem",
  }
}

node 'puppet-enterprise-master.puppetdebug.vlan' {
  class { 'hdp::data_processor':
       hdp_url =>  'https://agent-to-puppet-enterprise-master.puppetdebug.vlan:9091',
    }
}
