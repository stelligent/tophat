packages = node.default['jenkins-config']['prereqs']['packages']
packages.each do |package|
  package package
end
