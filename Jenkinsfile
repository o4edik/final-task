pipeline {
    agent { docker { image 'maven:latest' } }
    stages {
        stage('git checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/o4edik/final-task.git']]])

            }
        }
        stage('create artifact') {
            steps {
                sh '''
                mvn install -Dcheckstyle.skip
                cp target/*.jar ~/epam/DevOps_online_Kiev_2021Q4/m13/final-task
                '''
            }
        }

    } 
}