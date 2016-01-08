require 'spec_helper'

# RedHat has curl
describe command('curl -s -o ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar'),
         :if => os[:family] == 'redhat' do
  its(:exit_status) { should eq 0 }
end

# Ubuntu has wget
describe command('wget -q -O ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar'),
         :if => os[:family] == 'ubuntu' do
  its(:exit_status) { should eq 0 }
end

describe command('java -jar ~/jenkins-cli.jar -s http://127.0.0.1:8080/ list-plugins') do
	its(:exit_status) { should eq 0 }
  its(:stdout) { should_not match /\)$/ }
end
