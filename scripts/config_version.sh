#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null
PE_ENVIRONMENT_PATH="$(dirname -- "$SCRIPTPATH")"
#PE_ENVIRONMENTS_PATH="$(dirname -- "$PE_ENVIRONMENT_PATH")"
#PE_ENVIRONMENT=$(basename -- "$PE_ENVIRONMENT_PATH")

if [ -e $PE_ENVIRONMENT_PATH/.r10k-deploy.json ]
then
  /opt/puppetlabs/puppet/bin/ruby $PE_ENVIRONMENT_PATH/scripts/code_manager_config_version.rb $PE_ENVIRONMENT_PATH
elif [ -e /opt/puppetlabs/server/pe_version ]
then
  /opt/puppetlabs/puppet/bin/ruby $PE_ENVIRONMENT_PATH/scripts/config_version.rb $PE_ENVIRONMENT_PATH
else
  /usr/bin/git --version > /dev/null 2>&1 &&
  /usr/bin/git --git-dir PE_ENVIRONMENT_PATH/.git rev-parse HEAD ||
  date +%s
fi
