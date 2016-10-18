#!/opt/puppetlabs/puppet/bin/ruby

script_path = File.expand_path(File.dirname(__FILE__))
puppet_environment_path = File.dirname(script_path)

environment_r10k_deploy_file = File.join(puppet_environment_path, '.r10k-deploy.json')
environment_git_dir = File.join(puppet_environment_path, '.git')

pe_version_file = '/opt/puppetlabs/server/pe_version'

time_now_in_seconds = Time.now.to_i

if (File.file?(environment_r10k_deploy_file))
  begin
    require 'json'
  rescue LoadError => e
    puts time_now_in_seconds
  else
    deploy_file_json = JSON.parse(File.read(environment_r10k_deploy_file))
    deploy_file_signature = deploy_file_json['signature']
    puts deploy_file_signature                       
  end
elsif (File.file?(pe_version_file))
  begin
    require 'rugged'
  rescue LoadError => e
    puts time_now_in_seconds
  else
    repo = Rugged::Repository.discover(puppet_environment_path)
    repo_head  = repo.head
    repo_head_sha = repo_head.target_id
    repo_head_commit_message = repo.lookup(repo_head_sha)
    # todo: add something to find the remote url
    puts repo_head_sha                       
  end
else
  git_head_sha = %x( /usr/bin/git --git-dir #{environment_git_dir} rev-parse HEAD > /dev/null 2>&1 )
  git_exitstatus = $?.exitstatus
  if (exitstatus == 0)
    puts git_head_sha
  else
    puts time_now_in_seconds
  end
end
