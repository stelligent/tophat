require 'serverspec'

set :backend, :exec

describe command('curl -s -o ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar') do
	its(:exit_status) { should eq 0 }
end

describe command('java -jar ~/jenkins-cli.jar -s http://127.0.0.1:8080/ list-plugins') do
	its(:exit_status) { should eq 0 }
  its(:stdout) { should_not match /\)$/ }
end
