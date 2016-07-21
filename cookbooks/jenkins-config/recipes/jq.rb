remote_file '/usr/bin/jq' do
  source 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end