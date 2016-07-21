require 'spec_helper'

describe file('/usr/bin/jq') do

  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command('jq --version') do
  its(:stdout) { should match /1\.5/ }
end