pipeline {
    agent { 
        docker { 
            image 'maven:latest' 
            args '-v $HOME/.m2:/root/.m2'
            }
        }
    stages {
        stage('git checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/o4edik/final-task.git']]])

            }
        }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests -Dcheckstyle.skip clean package'
                }
            }
        stage('Copy artifact') {
            steps {
                sh 'sudo cp /root/.m2/target/*.jar /home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod/prod.jar'
                }
            }
        }

    } 
