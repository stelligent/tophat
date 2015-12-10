jenkins_script 'add_authentication' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    import hudson.security.*

    def instance = Jenkins.getInstance()

    def hudsonRealm = new HudsonPrivateSecurityRealm(false)

    def userdetails = null
    try {
      userdetails = hudsonRealm.loadUserByUsername("stelligent")
    } catch (e) {
      assert e in org.acegisecurity.userdetails.UsernameNotFoundException
    }

    if (userdetails == null) {
      hudsonRealm.createAccount("stelligent","Automation4thePPL")
      instance.setSecurityRealm(hudsonRealm)

      def strategy = new GlobalMatrixAuthorizationStrategy()
      strategy.add(Jenkins.ADMINISTER, "stelligent")
      strategy.add(Jenkins.READ, "anonymous")
      instance.setAuthorizationStrategy(strategy)
      instance.save()
    }
  EOH
end
