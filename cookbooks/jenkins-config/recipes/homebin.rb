cookbook_file '/etc/profile.d/zz-home-bin.sh' do
  source 'etc-profile-d-homebin.sh'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
