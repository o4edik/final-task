pipeline {
    agent { docker { image 'maven:3.8.4-openjdk-11-slim' } }
    stages {
        stage('git checkout') {
            steps {
                sh 'git clone https://github.com/o4edik/petclinic.git https://github.com/o4edik/DevOps_online_Kiev_2021Q4/tree/master/m13/'
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