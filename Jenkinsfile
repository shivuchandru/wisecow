pipeline {
    agent any

    environment {
        REGISTRY = "docker.io"
        IMAGE_NAME = "dockerhub_username/wisecow"   // 👈 change to your Docker Hub repo
        K8S_NAMESPACE = "default"                   // or create `wisecow` namespace
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shivuchandru/Wisecow-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${REGISTRY}", 'dockerhub-credentials') {
                        docker.image("${IMAGE_NAME}:${BUILD_NUMBER}").push()
                        docker.image("${IMAGE_NAME}:${BUILD_NUMBER}").push("latest")
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Apply manifests (ensure kubectl is configured)
                    sh """
                      kubectl apply -f k8s/deployment.yaml
                      kubectl apply -f k8s/service.yaml
                      kubectl set image deployment/wisecow wisecow=${IMAGE_NAME}:${BUILD_NUMBER} -n ${K8S_NAMESPACE}
                      kubectl rollout status deployment/wisecow -n ${K8S_NAMESPACE}
                    """
                }
            }
        }
    }
}
