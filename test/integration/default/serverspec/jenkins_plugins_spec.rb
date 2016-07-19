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
  plugins = %w(
    git
    job-dsl
    envinject
    rvm
    token-macro
    ruby-runtime
    ansicolor
    matrix-auth
    aws-codepipeline
    workflow-aggregator
    workflow-support
    workflow-cps
    pipeline-stage-step
    pipeline-stage-view
    workflow-cps-global-lib
    pipeline-input-step
    workflow-basic-steps
    workflow-multibranch
    workflow-scm-step
    workflow-job
    workflow-durable-task-step
    workflow-step-api
    pipeline-build-step
    workflow-api
  )
  plugins.each do |plugin|
    its(:stdout) { should match /#{plugin}/ }
  end
end
