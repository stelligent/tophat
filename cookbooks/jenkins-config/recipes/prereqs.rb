include_recipe 'yum-epel::default' if node['platform_family'] == 'rhel'

node['jenkins-config']['prereq']['packages'].each do |package|
  package package
end

apt_package 'openjdk-7-jdk' do
  options '--no-install-recommends'
  version node['java']['openjdk_version'] if node['java']['openjdk_version']
  only_if { node['platform_family'] == 'debian' }
end