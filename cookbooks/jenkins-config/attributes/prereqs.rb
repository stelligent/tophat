if ['rhel'].include?(node['platform_family'])
  node.default['jenkins-config']['prereq']['packages'] = %w{patch libyaml-devel glibc-headers autoconf gcc-c++ glibc-devel readline-devel zlib-devel libffi-devel openssl-devel automake libtool bison sqlite-devel python-pip git mlocate}
elsif ['debian'].include?(node['platform_family'])
  node.default['jenkins-config']['prereq']['packages'] = %w{patch libyaml-dev libc6-dev autoconf gcc libreadline-dev zlib1g-dev libffi-dev openssl automake libtool bison libsqlite3-dev python-pip git mlocate}
end


