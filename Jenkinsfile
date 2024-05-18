pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/anveshgithub/Chekk-Test.git'
            }
        }
    
        stage('Build with Maven') { 
            steps {
                sh 'mvn clean package -f MySpring_Boot_aa23v_VotingApp_Final/pom.xml -DbuildNumber=${BUILD_NUMBER}'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t ushkamalla/test:${BUILD_NUMBER}  .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([usernamePassword(credentialsId: 'test-pwd', passwordVariable: 'passwird', usernameVariable: 'ushkamalla')]) {
                   

                   sh 'docker push ushkamalla/test:${BUILD_NUMBER}'
                }
            }
          }
        }
    }     
        
}      
