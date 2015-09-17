packages = %w{patch libyaml-devel glibc-headers autoconf gcc-c++ glibc-devel readline-devel zlib-devel libffi-devel openssl-devel automake libtool bison sqlite-devel python-pip git mlocate}
packages.each do |package|
  package package
end

remote_file "#{Chef::Config[:file_cache_path]}/chefdk.rpm" do
    source "https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.7.0-1.el6.x86_64.rpm"
    action :create
end

package "chefdk" do
    source "#{Chef::Config[:file_cache_path]}/chefdk.rpm"
end
