pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        APP_NAME        = 'youtube-clone'
        DOCKERHUB_USER  = 'skbablualam03031997'
        IMAGE_NAME      = "${DOCKERHUB_USER}/youtube_clone"
        IMAGE_TAG       = "${BUILD_NUMBER}"
        NAMESPACE       = 'youtube'
        SONAR_PROJECT   = 'youtube_clone'
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    tools {
        nodejs 'node20' // This must exactly match the name you set in Step 2
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
                echo 'Installing npm packages...'
                sh 'npm install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'npm test -- --watchAll=false || true'
            }
        }

        stage('SonarCloud Analysis') {
            when {
                expression { env.SONAR_TOKEN != null }
            }
            steps {
                echo 'Running SonarCloud analysis...'
                sh '''
                sonar-scanner \
                  -Dsonar.projectKey=skbablualam_youtube_clone \
                  -Dsonar.sources=src \
                  -Dsonar.host.url=https://sonarcloud.io \
                  -Dsonar.login=$SONAR_TOKEN || true
                '''
            }
        }

        stage('Trivy Filesystem Scan') {
            steps {
                echo 'Scanning project files...'
                sh 'trivy fs . || true'
            }
        }

        stage('Build React Application') {
            steps {
                echo 'Building React application...'
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'

                sh """
                docker build \
                -t ${IMAGE_NAME}:${IMAGE_TAG} \
                -t ${IMAGE_NAME}:latest .
                """
            }
        }

        stage('Trivy Image Scan') {
            steps {
                echo 'Scanning Docker image...'

                sh """
                trivy image ${IMAGE_NAME}:${IMAGE_TAG} || true
                """
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub...'

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh """
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${IMAGE_NAME}:latest
                    docker logout
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying application...'

                sh '''
                kubectl apply -f k8s/namespace.yaml
                kubectl apply -f k8s/deployment.yaml
                kubectl apply -f k8s/service.yaml
                kubectl apply -f k8s/ingress.yaml
                '''

                sh """
                kubectl set image deployment/${APP_NAME} \
                ${APP_NAME}=${IMAGE_NAME}:${IMAGE_TAG} \
                -n ${NAMESPACE}
                """

                sh """
                kubectl rollout status deployment/${APP_NAME} \
                -n ${NAMESPACE}
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                sh "kubectl get pods -n ${NAMESPACE}"
                sh "kubectl get svc -n ${NAMESPACE}"
            }
        }
    }

    post {
        success {
            echo ''
            echo '======================================='
            echo ' Pipeline completed successfully!'
            echo '======================================='
        }

        failure {
            echo ''
            echo '======================================='
            echo ' Pipeline failed!'
            echo '======================================='
        }

        always {
            cleanWs()
        }
    }
}
