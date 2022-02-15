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
                
                sh 'mvn install -Dcheckstyle.skip'

                }
                dir ('.') {
                    sh ' cp final-task/target/*.jar final-task/prod/prod.jar '
                }
            }
        }

    } 
}