require 'spec_helper'

# RedHat has curl
describe command('curl -s -o ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar'),
         :if => %w(redhat amazon).include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

# Ubuntu has wget
describe command('wget -q -O ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar'),
         :if => os[:family] == 'ubuntu' do
  its(:exit_status) { should eq 0 }
end

# verify all plugins defined in the plugins list
# are output by the jenkins cli utility as installed
# TODO
# version checking
describe command('java -jar ~/jenkins-cli.jar -s http://127.0.0.1:8080/ list-plugins') do
  its(:exit_status) { should eq 0 }
  plugins = %w(git job-dsl envinject rvm token-macro
              ruby-runtime ansicolor delivery-pipeline-plugin
              aws-codepipeline)
  plugins.each do |plugin|
    its(:stdout) { should match /#{plugin}/ }
  end
end
