pipeline {
    agent { docker { image 'maven:latest' } }
    stages {
        stage('git checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/o4edik/final-task.git']]])
                sh 'git clone git@github.com:o4edik/final-task.git /home/petclinic'
            }
        }
        stage('create artifact') {
            steps {
                sh '''
                cd petclinic
                ./mvnw package
                java -jar target/*.jar
                '''
            }
        }
        stage('build') {
            steps {
                sh './mvnw spring-boot:run'
            }
        }
    } 
}