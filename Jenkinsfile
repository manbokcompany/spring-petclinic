pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                echo 'Git Clone'
                git url: 'https://github.com/manbokcompany/spring-petclinic.git', 
                branch: 'main'
            }
        }
    }
}
