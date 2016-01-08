require 'serverspec'

set :backend, :exec

describe package('jenkins'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('jenkins'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('jenkins'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('jenkins'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening.with('tcp') }
end

# RedHat defaults to having curl installed
describe command('curl -s http://127.0.0.1:8080/'), :if => os[:family] == 'redhat' do
	its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Log in<\/a> to create new jobs/ }
end

# Ubuntu defaults to having wget installed
describe command('wget -q -O - http://127.0.0.1:8080/'), :if => os[:family] == 'ubuntu' do
	its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Log in<\/a> to create new jobs/ }
end
