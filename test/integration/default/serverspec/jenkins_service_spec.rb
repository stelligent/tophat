require 'serverspec'

set :backend, :exec

describe service('jenkins') do
  it { should be_enabled }
end

describe service('jenkins') do
  it { should be_running }
end

describe port(8080) do
  it { should be_listening.with('tcp') }
end

describe command('curl -s http://127.0.0.1:8080/') do
	its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Log in<\/a> to create new jobs/ }
end
