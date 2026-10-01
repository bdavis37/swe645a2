pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'bdavis37'
        IMAGE_NAME = 'assignment-two'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps{
                git 'https://github.com/bdavis37/swe645a2.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-cred') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Update Kubernetes Deployment') {
            steps {
                script {
                    sh """
                    sed -i 's|bdavis37/assignment-two:latest|${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}|' k8s/deployment.yam1
                    kubectl apply -f k8s/dep10yment .yaml
                    kubectl apply -f k8s/service.yam1
                    """
                }
                echo 'Deploying....'
            }
        }
        post {
            success {
                echo 'Deployment success'
            }
            failure {
                echo 'Deployment failed'
            }
        }
    }
}