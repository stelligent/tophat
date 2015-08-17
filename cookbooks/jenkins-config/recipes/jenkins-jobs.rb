template "/var/tmp/job-seed.xml" do
  source 'job-seed.xml.erb'

  variables(
    {
    :source_repo => "https://github.com/stelligent/keystore.git"
    }
  )
end

jenkins_job "job-seed" do
  action :create
  config "/var/tmp/job-seed.xml"
end
