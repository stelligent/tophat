require 'spec_helper'

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
  it { should be_listening }
end
