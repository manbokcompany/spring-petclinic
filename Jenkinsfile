pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USER = 'manbokcompany'
        IMAGE_NAME = 'spring-petclinic'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manbokcompany/spring-petclinic.git'
            }
        }
        
        stage('Maven Build') {
            steps {
                sh './mvnw package -DskipTests'
            }
        }
        
        stage('Docker Build') {
            steps {
                sh """
                    docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} .
                    docker tag ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} \
                               ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest
                """
            }
        }
        
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl apply -f k8s/petclinic-deployment.yaml
                        kubectl apply -f k8s/petclinic-ingress.yaml
                        kubectl apply -f k8s/petclinic-name.yaml
                        kubectl apply -f k8s/petclinic-service.yaml
                        kubectl rollout status deployment/petclinic -n petclinic-team2
                    '''
                }
            }
        }

        stage('Docker Clean') {
            steps {
                sh '''
                docker rmi spring-petclinic:${BUILD_NUMBER}
                docker rmi manbokcompany/spring-petclinic:${BUILD_NUMBER}
                '''
            }
        }

    }  // ← stages 닫기

    post {
        always {
            sh 'docker logout'
        }
    }
}  // ← pipeline 닫기
