pipeline {

    agent any

    triggers {
        githubPush()
    }

    environment {
        APP_NAME      = "youtube-clone"
        IMAGE_NAME    = "youtube-clone"
        IMAGE_TAG     = "${BUILD_NUMBER}"
        NAMESPACE     = "youtube"
        SONAR_PROJECT = "youtube-clone"
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {

        stage('Checkout Source') {
            steps {
                echo "Checking out source code..."
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Installing npm packages..."
                sh 'npm install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo "Running unit tests..."
                sh 'npm test -- --watchAll=false || true'
            }
        }

        stage('SonarCloud Analysis') {
            when {
                expression { env.SONAR_TOKEN != null }
            }
            steps {
                echo "Running SonarCloud analysis..."
                sh '''
                sonar-scanner \
                  -Dsonar.projectKey=youtube-clone \
                  -Dsonar.sources=src \
                  -Dsonar.host.url=https://sonarcloud.io \
                  -Dsonar.login=$SONAR_TOKEN || true
                '''
            }
        }

        stage('Trivy Filesystem Scan') {
            steps {
                echo "Scanning project files..."
                sh 'trivy fs . || true'
            }
        }

        stage('Build React Application') {
            steps {
                echo "Building React application..."
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh """
                docker build \
                -t ${IMAGE_NAME}:${IMAGE_TAG} \
                -t ${IMAGE_NAME}:latest .
                """
            }
        }

        stage('Trivy Image Scan') {
            steps {
                echo "Scanning Docker image..."
                sh "trivy image ${IMAGE_NAME}:${IMAGE_TAG} || true"
            }
        }

        stage('Load Image into Minikube') {
            steps {
                echo "Loading image into Minikube..."
                sh "minikube image load ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {

                echo "Deploying application..."

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
            echo ""
            echo "======================================="
            echo " Pipeline completed successfully!"
            echo "======================================="
        }

        failure {
            echo ""
            echo "======================================="
            echo " Pipeline failed!"
            echo "======================================="
        }

        always {
            cleanWs()
        }
    }
}