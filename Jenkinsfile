pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        APP_NAME = 'youtube-clone'
        IMAGE_NAME = 'youtube-clone'
        IMAGE_TAG = env.BUILD_NUMBER ?: 'local'
        K8S_NAMESPACE = 'youtube'
    }

    stages {
        stage('Checkout Source') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build React Application') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Load Image Into Minikube') {
            steps {
                sh "minikube image load ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh "kubectl apply -f k8s/namespace.yaml"
                sh "kubectl apply -f k8s/deployment.yaml"
                sh "kubectl apply -f k8s/service.yaml"
                sh "kubectl set image deployment/${APP_NAME} ${APP_NAME}=${IMAGE_NAME}:${IMAGE_TAG} -n ${K8S_NAMESPACE}"
                sh "kubectl rollout status deployment/${APP_NAME} -n ${K8S_NAMESPACE}"
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully.'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}