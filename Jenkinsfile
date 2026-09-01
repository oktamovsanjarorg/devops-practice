pipeline {
    agent any

    stages {
        stage('1. Checkout') {
            steps {
                echo 'GitHubdan kod muvaffaqiyatli tortib olindi!'
                sh 'ls -la'
            }
        }

        stage('2. Test') {
            steps {
                echo 'Loyiha fayllari tekshirilmoqda...'
                sh 'echo "Test muvaffaqiyatli otdi!"'
            }
        }

        stage('3. Build') {
            steps {
                echo 'Loyiha yigilmoqda...'
                sh 'echo "Qurilish yakunlandi!"'
            }
        }

        stage('4. Health'){
        	steps{
        		echo "tizim 100% sog'lom !"
        	}
        }
    }

    post {
        success {
            echo ' Jenkinsfile muvaffaqiyatli ishladi!'
        }
        failure {
            echo ' Jenkinsfile ishlashida xatolik yuz berdi!'
        }
    }
}
