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
        
        stage('Build Docker Image') { // Capitalized "Image" for consistency
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
        
        stage('Update Image Tag in Manifest (CD)') { // Improved clarity
            steps {
                script {
                    // Checkout the deployment repository (assuming separate repo)
                    git branch: 'master', url: 'https://github.com/anveshgithub/K8-S.git'
                    
                    // Update deployment.yaml with image tag using 'sh' or a dedicated library (consider security)
                    sh 'sed -i "s/ushkamalla\/test:[^:]*/ushkamalla\/test:${BUILD_NUMBER}" deployment.yaml' // Use with caution
                    
                    // Add and commit changes (requires security considerations)
                    git add 'deployment.yaml'
                    git commit message: "Build #${BUILD_NUMBER}: Update image and manifest"
                    git push origin master
                }
            }
        }
    }
}
