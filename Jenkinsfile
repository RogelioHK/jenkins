pipeline {

  environment {
    dockerimagename = "bigredrocketoflove/lemp"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/RogelioHK/jenkins.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("v2.0.1")
          }
        }
      }
    }

    stage('Deploying lemp container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "lemp-deploy.yaml", "lemp-svc.yaml")
        }
      }
    }

  }

}
