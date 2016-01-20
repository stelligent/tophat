include_recipe 'jenkins-config::default'
include_recipe 'jenkins::master'
include_recipe 'jenkins-config::jenkins-plugins'
# include_recipe 'jenkins-config::jenkins-jobs'
include_recipe 'jenkins-config::homebin'

service 'jenkins' do
  action :restart
end
