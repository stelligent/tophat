packages = %w{patch libyaml-devel glibc-headers autoconf gcc-c++ glibc-devel readline-devel zlib-devel libffi-devel openssl-devel automake libtool bison sqlite-devel python-pip git mlocate}
packages.each do |package|
  package package
end
