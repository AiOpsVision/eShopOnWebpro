pipelineJob('eshoponweb-CI') {
  description('Pipeline for building, testing and deploying eShopOnWeb from GitHub')
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url('https://github.com/AiOpsVision/eShopOnWeb.git')
            credentials('github-creds')
          }
          branches('*/main')
        }
      }
      scriptPath('Jenkinsfile-CI')
    }
  }
  triggers {
    scm('H/1 * * * *')  
  }
  logRotator {
    numToKeep(-1)       
    daysToKeep(-1)      
  }
}

pipelineJob('eshoponweb-CD') {
  description('Pipeline for deploying eShopOnWeb (CD)')
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url('https://github.com/AiOpsVision/eShopOnWeb.git')
            credentials('github-creds')
          }
          branches('*/main')
        }
      }
      scriptPath('Jenkinsfile-CD') 
    }
  }
  logRotator {
    numToKeep(10)
  }
}