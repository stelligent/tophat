require 'spec_helper'

case os[:family]

  when 'redhat'
    prereq_package_names = %w{
      initscripts patch libyaml-devel glibc-headers autoconf
      gcc-c++ glibc-devel readline-devel zlib-devel libffi-devel
      openssl-devel automake libtool bison sqlite-devel
      python-pip git mlocate
    }

  when 'ubuntu'
    prereq_package_names = %w{
      patch libyaml-dev libc6-dev autoconf gcc libreadline-dev zlib1g-dev
      libffi-dev openssl automake libtool bison libsqlite3-dev python-pip
      git mlocate
    }
end

prereq_package_names.each do |prereq_package_name|
  describe package(prereq_package_name)  do
    it { should be_installed }
  end
end