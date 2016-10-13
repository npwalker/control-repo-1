require 'json'

puppet_environment_path = ARGV[0]

r10k_deploy_file_path = File.join(puppet_environment_path, '.r10k-deploy.json')

#output the sha1 from the control-repo
puts JSON.parse(File.read(r10k_deploy_file_path))['signature']
