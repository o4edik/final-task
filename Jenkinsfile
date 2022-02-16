pipeline {
    agent {
        docker { 
            image 'maven:latest' 
            // args '-v $HOME/.m2:/root/.m2'
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

        stage('Copy artifact to project folder') {
            steps {
                copyArtifacts flatten: true, parameters: '*.jar', projectName: 'petclinic_pipe', selector: workspace(), target: '/home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod/'
            }
        }
        stage('Innit_prod_env_with_TF') {
           environment {
            prod_ip = ''
            }
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/o4edik/final-task.git']]])
                dir('/home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod') {
                sh '''
                terraform init
                terraform apply --auto-approve
                '''
                script {
                    prod_ip = sh(returnStdout: true, script: "terraform output -raw Prod_Env_publicIP").trim()
                }
                writeFile (file: '/home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod/ahosts.txt', text: '[prod]\n' + Prod_server + ansible_host= + prod_ip + 'ansible_user=ubuntu' + 'ansible_ssh_private_key_file=/home/ed/awspemkeys/id_rsa_ec2.pem')
            }

        }
        stage('Copy artifact to AWS prod instance') {
              steps {
                sh 'scp -i /home/ed/awspemkeys/id_rsa_ec2.pem /home/ed/epam/DevOps_online_Kiev_2021Q4/m13/final-task/prod/*.jar ubuntu@$prod_ip:~ '
            }         
        }
        stage('Deploy on prod env with Ansible') {
              steps {
                sh 'ansible-playbook deploy_prod.yml'
            }         
        }
    
    }
    }
}