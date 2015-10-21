if ['rhel', 'amazon'].include?(node['platform'])
  execute 'yum upgrade -y'
end
if ['ubuntu'].include?(node['platform'])
  execute 'aptitude update'
  execute 'aptitude upgrade -y'
end

include_recipe 'jenkins-config::jenkins-yum-prereqs'
include_recipe 'java'
include_recipe 'git'
include_recipe 'jenkins::master'
include_recipe 'jenkins-config::jenkins-plugins'
# include_recipe 'jenkins-config::jenkins-jobs'
include_recipe 'jenkins-config::homebin'

service 'jenkins' do
  action :restart
end
