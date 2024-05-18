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
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ushkamalla/test:${BUILD_NUMBER} .'
                }
            }
        }
        
        stage('Push Image to Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'test-pwd', passwordVariable: 'password', usernameVariable: 'ushkamalla')]) {
                        sh 'docker push ushkamalla/test:${BUILD_NUMBER}'
                    }
                }
            }
        }
        
        stage('Update Image Tag in Manifest (CD)') {
            steps {
                script {
                        withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]) {
                        sh "sed -i 's#ushkamalla/test:[^:]*#ushkamalla/test:${BUILD_NUMBER}#' deployment.yaml"
                        sh "git add deployment.yaml"
                        sh "git config --global user.email "anveshushkamalla123@gmail.com"
                        sh "git config --global user.name "anvesh ushkamalla"    
                        sh "git commit -m 'updating manifests with image id'"
                        sh "git push origin master"
                    }
                }
            }
        }
    }
}
