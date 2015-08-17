include_recipe 'java'
include_recipe 'git'
include_recipe 'jenkins::master'
include_recipe 'jenkins-config::jenkins-plugins'
include_recipe 'jenkins-config::jenkins-jobs'

service 'jenkins' do
  action :restart
end
