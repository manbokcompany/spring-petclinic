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
        stage('maven Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Docker Image Build && Push') {
            steps {
                sh '''
                docker build -t spring-petclinic:${BUILD_NUMBER} .
                docker tag spring-petclinic:${BUILD_NUMBER} manbokcompany/spring-petclinic:latest
                echo ${DOCKERHUB_CRED_PSW} | docker login -u ${DOCKERHUB_CRED_USR} --password-stdin
                docker push manbokcompany/spring-petclinic:latest
                '''
            }
        }












        
    }
}
        
