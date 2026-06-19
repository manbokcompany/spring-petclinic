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
        stage('Docker image Remove') {
            steps {
                sh '''
                docker rmi -f manbokcompany/spring-petclinic:latest
                docker rmi -f spring-petclinic:${BUILD_NUMBER}
                '''
            }
        }
        stage('Upload S3') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh 'zip -r scripts.zip ./scripts appspec.yml'
                    withAWS(region: "ap-northeast-2", credentials: "${AWS_CREDENTIAL_NAME}"){
                        s3Upload(file: "scripts.zip", bucket: "std09-app.busanit.com")
                    }
                    sh 'rm -rf scripts.zip'  
                }
            }
        }
        stage('Code Deploy') {
            steps {
                withAWS(region: "ap-northeast-2", credentials: "${AWS_CREDENTIAL_NAME}"){  
                    sh '''
                    aws deploy create-deployment-group \
                    --application-name std09-exercise \
                    --auto-scaling-groups std09-exercise \
                    --deployment-group-name std09-exercise-${BUILD_NUMBER} \
                    --deployment-config-name CodeDeployDefault.OneAtATime \
                    --service-role-arn std09-exercise-doe-deploy-role \
                    '''
                    sh '''
                    aws deploy create-deployment --application-name std09-exercise \
                    --deployment-config-name CodeDeployDefault.OneAtATime \
                    --deployment-group-name std09-exercise-${BUILD_NUMBER} \
                    --s3-location bucket=std09-app.busanit.com,bundleType=zip,key=scriptes.zip
                    '''
                    sleep(10)
                }
            }
        }
    }   
}
        
