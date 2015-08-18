jenkins_plugin 'git'
jenkins_plugin 'job-dsl'
jenkins_plugin 'envinject'
jenkins_plugin 'rvm'
jenkins_plugin 'token-macro'
jenkins_plugin 'ruby-runtime'
jenkins_plugin 'ansicolor'

remote_file '/var/lib/jenkins/plugins/aws-codepipeline-plugin-for-jenkins.hpi' do
  source 'https://github.com/awslabs/aws-codepipeline-plugin-for-jenkins/blob/master/dist/aws-codepipeline-plugin-for-jenkins.hpi?raw=true'
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
  action :create
end
