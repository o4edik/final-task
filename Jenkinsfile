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
        stage('Create artifact') {
            steps {
                sh 'mvn -B -DskipTests -Dcheckstyle.skip clean package'
            }         
        }
        stage('Zip artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }
        stage('Copy artifact') {
            steps {
                script {
                  step ([$class: 'CopyArtifact',
                      projectName: 'Zip artifact',
                      filter: 'target/*.jar',
                      target: '/home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod/prod.jar']);
            }
        }    
    }

} 
