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
                sh 'mvn clean package'
            }
        }
        stage('Deploy to Server') {
            when { 
                expression { return environment == 'production' } 
            }
            steps {
                script {
                    def warFile = "${env.WORKSPACE}/target/*.war"
                    // Here's an example using SSH transfer:
                    sh """
                        scp -o StrictHostKeyChecking=no ${warFile} user@server_ip:/path/to/tomcat/webapps/your-app.war
                    """
                    // Replace with your server details (username, IP, path) and adjust the scp command accordingly.
                }
            }
        }
    }
}
