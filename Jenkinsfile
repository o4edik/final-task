pipeline {
    agent { 
        docker { 
            image 'maven:latest' 
            args '-v $HOME/.m2:/root/.m2'
            }
        }
        environment {
            IMAGE_BASE = ''
            IMAGE_TAG = 'v$BUILD_NUMBER'
            IMAGE_NAME = '${env.IMAGE_BASE}:${env.IMAGE_TAG}'
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
        // stage('Copy artifact') {
        //     steps {
        //         script {
        //           step ([$class: 'CopyArtifact',
        //               projectName: 'petclinic_pipe',
        //               filter: '*.jar',
        //               target: '/home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod/']);
        //     }
        // }
        stage('Innit_prod_env_with_TF') {
            steps {
                sh 'cd /home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod'
            }
        }    
    }

} 
