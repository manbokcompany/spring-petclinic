pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                echo 'Git Clone'
                git url: 'https://github.com/sjh4616/spring-petclinic-602.git', 
                branch: 'main'
            }
        }
    }
}
