service { 'pe-puppetserver':
  ensure     => 'running',
  enable     => false,
  hasrestart => false, # Force Puppet to use start and stop to restart
  start      => 'echo "Start"', # This will always exit 0
  stop       => 'echo "Stop"', # This will also always exit 0
  hasstatus  => false, # Force puppet to use our command for status
  status     => 'echo "Status"', # This will always exit 0 and therefore Puppet will think the service is running
  provider   => 'base',
}
