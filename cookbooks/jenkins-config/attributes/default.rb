if ['rhel'].include?(node['platform_family'])
  # default repository should be the Long-Term Support release
  # https://wiki.jenkins-ci.org/display/JENKINS/LTS+Release+Line
  node.default['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/redhat-stable'
  node.default['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key'
end
if ['debian'].include?(node['platform_family'])
  node.default['apt']['compile_time_update'] = true
  # default repository should be the Long-Term Support release
  # https://wiki.jenkins-ci.org/display/JENKINS/LTS+Release+Line
  node.default['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/debian-stable'
  node.default['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
end
