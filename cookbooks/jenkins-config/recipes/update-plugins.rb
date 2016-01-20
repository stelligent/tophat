# Cookbook Name:: jenkins-config
# Recipe:: update-plugins
#
# Update installed plugins to latest version

# XXX this code is broken on Ubuntu 
# (curl not installed by default)
#
# Is this the best way?

bash 'update jenkins plugins' do
  flags '-ex'
  code <<-EOB
    wait_for_jenkins() {
      count=0
      jenkins_running='false';
      while [ "$jenkins_running" = 'false' ]; do
        test $count -lt 30 || exit 1
        if curl -s -o ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar && \
           file ~/jenkins-cli.jar | grep -q 'Zip archive'; then
          jenkins_running='true'
        else
          sleep 3
        fi
        count=$(($count + 1))
      done
    }

    wait_for_jenkins

    [ -e ~/jenkins-cli.jar ] || \
      curl -s -o ~/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar

    UPDATE_LIST=$(java -jar ~/jenkins-cli.jar -s http://127.0.0.1:8080/ list-plugins | grep ')$' | awk '{ print $1 }')
    [ -n "${UPDATE_LIST}" ] || exit 0

    echo Updating Jenkins Plugins: ${UPDATE_LIST};
    java -jar ~/jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin ${UPDATE_LIST}

    java -jar ~/jenkins-cli.jar -s http://127.0.0.1:8080/ safe-restart
    sleep 10
    wait_for_jenkins
  EOB
end

