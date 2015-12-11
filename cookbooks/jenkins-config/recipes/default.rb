if ['rhel'].include?(node['platform_family'])
  # XXX should this instead do security updates instead of full
  # system updates?
  execute 'yum upgrade -y'
end
if ['debian'].include?(node['platform_family'])
  include_recipe 'apt::default'
  # XXX should this instead do security updates instead of full
  # system updates?
  execute 'apt-get upgrade -y' do
    environment ({'DEBIAN_FRONTEND' => 'noninteractive'})
  end
end

include_recipe 'jenkins-config::prereqs'
include_recipe 'java'
include_recipe 'git'
include_recipe 'jenkins::master'
include_recipe 'jenkins-config::jenkins-plugins'
# include_recipe 'jenkins-config::jenkins-jobs'
include_recipe 'jenkins-config::homebin'
include_recipe 'jenkins-config::jenkins-auth'
