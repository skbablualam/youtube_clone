pipeline {

    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {

        APP_NAME = "youtube-clone"

        DOCKER_USERNAME = "YOUR_DOCKERHUB_USERNAME"

        IMAGE_NAME = "${DOCKER_USERNAME}/${APP_NAME}"

        IMAGE_TAG = "${BUILD_NUMBER}"

        K8S_NAMESPACE = "youtube"

        MINIKUBE_HOST = "YOUR_MINIKUBE_PUBLIC_IP"

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

                sh 'npm install'

            }

        }

        stage('Run Unit Tests') {

            steps {

                sh 'npm test -- --watchAll=false'

            }

        }

        stage('Build React Application') {

            steps {

                sh 'npm run build'

            }

        }

        stage('Build Docker Image') {

            steps {

                sh '''
                docker build \
                -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''

            }

        }

        stage('Push Image to Docker Hub') {

            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''

                    echo $DOCKER_PASS | docker login \
                    -u $DOCKER_USER \
                    --password-stdin

                    docker push ${IMAGE_NAME}:${IMAGE_TAG}

                    docker logout

                    '''

                }

            }

        }

        stage('Deploy to Minikube') {

            steps {

                sshagent(credentials: ['minikube-ssh']) {

                    sh """

                    ssh -o StrictHostKeyChecking=no ubuntu@${MINIKUBE_HOST} '

                    kubectl set image deployment/youtube-clone \
                    youtube-clone=${IMAGE_NAME}:${IMAGE_TAG} \
                    -n ${K8S_NAMESPACE}

                    kubectl rollout status deployment/youtube-clone \
                    -n ${K8S_NAMESPACE}

                    '

                    """

                }

            }

        }

    }

    post {

        success {

            echo "Deployment Successful"

        }

        failure {

            echo "Pipeline Failed"

        }

        always {

            cleanWs()

        }

    }

}