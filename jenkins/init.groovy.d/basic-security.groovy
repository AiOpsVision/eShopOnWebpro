#!groovy

import jenkins.model.*
import hudson.security.*
import jenkins.install.InstallState
import java.nio.file.*

System.setProperty("jenkins.install.runSetupWizard", "false")

def instance = Jenkins.getInstance()


instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

// ✅ 
println "--> Security is enabled and open access is disabled (before JCasC is loaded)"


def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(System.getenv("JENKINS_ADMIN_USER"), System.getenv("JENKINS_ADMIN_PASS"))
hudsonRealm.createAccount(System.getenv("JENKINS_DEV1_USER"), System.getenv("JENKINS_DEV1_PASS"))
hudsonRealm.createAccount(System.getenv("JENKINS_DEV2_USER"), System.getenv("JENKINS_DEV2_PASS"))
instance.setSecurityRealm(hudsonRealm)


def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

instance.save()
