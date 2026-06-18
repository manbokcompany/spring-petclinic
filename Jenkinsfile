pipeline {  
    agent any

    tools {
        jdk 'JDK21'
        maven 'M3'
    }
    environment {
        DOCKERHUB_CRED = credentials('dockerCredentials')
        AWS_CREDENTIAL_NAME = 'awsCredentials'
    }

    stages {
        stage('Git Clone') {
            steps {
                git url: 'https://github.com/manbokcompany/spring-petclinic.git' ,
                branch: 'main', credentialsId: 'gitCredentials'
            }
        }
        stage('Maven Build') {
            steps {

            }
        }
        stage('Upload S3') {
            steps {

            }
        }
        stage('Upload S3') {
            steps {

            }
        }
        stage('Code Deploy') {
            steps {

            }
        }
        stage('Docker Image Remove') {
            steps {

            }
        }
    }
}
        
