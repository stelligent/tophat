# node['jenkins-config']['jenkins-plugins'] should be an array
# of hashes like
#
# node['jenkins-config']['plugins'] = [
# { 'name' => 'git',
#   'version' => '2.4.0 },
# { 'name' => 'ssh-credentials',
#   'version' => '1.11',
#   'core' => true } ]
#
# name: required, name of plugin to install
# version: optional, version of plugin
# core: optional, whether to create a .pinned file for a core module
# pinned: optional, alias to core

node['jenkins-config']['jenkins-plugins'].each do |plugin|
  if plugin['core'] || plugin['pinned']
    file "/var/lib/jenkins/plugins/#{plugin['name']}.jpi.pinned" do
      mode   '0644'
      owner  node['jenkins']['master']['user']
      group  node['jenkins']['master']['group']
      action :touch
    end
  end
  jenkins_plugin plugin['name'] do
    version plugin['version'] unless plugin['version'].nil?
    retries 5
    retry_delay 15
  end
end unless node['jenkins-config']['jenkins-plugins'].nil? ||
           !node['jenkins-config']['jenkins-plugins'].respond_to?(:each)

log 'restarting jenkins after plugin installs' do
  notifies :restart, 'service[jenkins]', :immediately
end

