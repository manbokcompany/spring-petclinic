pipeline {
    agent any

    tools {
        jdk 'JDK21'
        mavem 'M3'
    }
    
    stages {
        // Github에서 소스코드 가져오기
        stage('Git Clone') {
            steps {
                echo 'Git Clone'
                git url: 'https://github.com/manbokcompany/spring-petclinic.git', 
                branch: 'main'
            }
        }

        // Maven으로 Build
        stage('Maven Build') {
                steps {
                    sh 'mvn -Dmaven.test.failure.ignore=true clean package'
            }
        }
    }
}
