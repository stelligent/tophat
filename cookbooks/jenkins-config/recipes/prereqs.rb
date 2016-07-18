include_recipe 'yum-epel::default' if node['platform_family'] == 'rhel'

node['jenkins-config']['prereq']['packages'].each do |package|
  package package
end
