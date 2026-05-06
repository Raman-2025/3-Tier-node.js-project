pipeline{
    agent { label 'vinod'}
    stages{
        stage('clone'){
            steps{
                git url:'https://github.com/Raman-2025/3-Tier-node.js-project.git' , branch: 'main'
            }
        }
        stage('build'){
            steps{
                sh 'docker build -t 3-tier-node:latest .'
            }
        }
        stage('push'){
            steps{
                withCredentials([usernamePassword(
                    credentialsId:'dockerHubCred',
                    usernameVariable:'dockerHubUser',
                    passwordVariable:'dockerHubPass' )]){
                sh '''
                docker login -u $dockerHubUser -p $dockerHubPass
                docker image tag 3-tier-node:latest  $dockerHubUser/3-tier-node:latest
                docker push $dockerHubUser/3-tier-node:latest'''
                }
            }
        }
        stage('deploy'){
            steps{
                sh 'docker compose down && docker compose up -d --build'
            }
        }        
    }
}
