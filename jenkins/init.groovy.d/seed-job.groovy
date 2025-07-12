import jenkins.model.*
import hudson.model.*
import javaposse.jobdsl.plugin.ExecuteDslScripts
import javaposse.jobdsl.plugin.RemovedJobAction

def jenkins = Jenkins.instance

if (!jenkins.getJob('seed-job')) {
    def job = new FreeStyleProject(jenkins, 'seed-job')

    def scriptFile = new File('/usr/share/jenkins/ref/jobs.groovy')
    if (scriptFile.exists()) {
        job.buildersList.add(new ExecuteDslScripts(
            scriptText: scriptFile.text,
            ignoreExisting: false,
            removedJobAction: RemovedJobAction.IGNORE
        ))
        jenkins.putItem(job)   
        job.save()
        println("✅ Seed Job Created and DSL loaded")
    } else {
        println("❌ jobs.groovy not found")
    }
} else {
    println("ℹ️ seed-job already exists")
}
