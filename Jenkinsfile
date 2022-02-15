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

} 
