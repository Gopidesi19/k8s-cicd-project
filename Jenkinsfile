pipeline {
    agent any

    environment {
        PROJECT_ID   = "my-devops-project-1"
        REGION       = "asia-south1"
        CLUSTER_NAME = "flask-gke-cluster"
        REPOSITORY   = "flask-app-repo"

        IMAGE_NAME = "flask-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"

        IMAGE_URI = "${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/<your-username>/k8s-cicd-project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate

                    pip install --upgrade pip
                    pip install -r app/requirements.txt
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest app/tests/
                '''
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                        . venv/bin/activate

                        sonar-scanner \
                          -Dsonar.projectKey=flask-gke-app \
                          -Dsonar.projectName="Flask GKE Application"
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_URI} .
                '''
            }
        }

        stage('Trivy Scan') {
            steps {
                sh '''
                    trivy image \
                      --severity HIGH,CRITICAL \
                      --exit-code 1 \
                      ${IMAGE_URI}
                '''
            }
        }

        stage('Authenticate to GCP') {
            steps {
                withCredentials([
                    file(
                        credentialsId: 'gcp-sa-key',
                        variable: 'GOOGLE_APPLICATION_CREDENTIALS'
                    )
                ]) {
                    sh '''
                        gcloud auth activate-service-account \
                          --key-file=$GOOGLE_APPLICATION_CREDENTIALS

                        gcloud config set project ${PROJECT_ID}

                        gcloud auth configure-docker \
                          ${REGION}-docker.pkg.dev --quiet
                    '''
                }
            }
        }

        stage('Push Image to Artifact Registry') {
            steps {
                sh '''
                    docker push ${IMAGE_URI}
                '''
            }
        }

        stage('Connect to GKE') {
            steps {
                withCredentials([
                    file(
                        credentialsId: 'gcp-sa-key',
                        variable: 'GOOGLE_APPLICATION_CREDENTIALS'
                    )
                ]) {
                    sh '''
                        gcloud auth activate-service-account \
                          --key-file=$GOOGLE_APPLICATION_CREDENTIALS

                        gcloud container clusters get-credentials \
                          ${CLUSTER_NAME} \
                          --region ${REGION} \
                          --project ${PROJECT_ID}
                    '''
                }
            }
        }

        stage('Deploy to GKE using Helm') {
            steps {
                sh '''
                    helm upgrade --install flask-app \
                      ./helm/flask-app \
                      --set image.repository=${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME} \
                      --set image.tag=${IMAGE_TAG}
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    kubectl rollout status deployment/flask-app

                    kubectl get pods
                    kubectl get svc
                '''
            }
        }
    }

    post {

        success {
            echo "Pipeline completed successfully."
            echo "Application deployed successfully to GKE."
        }

        failure {
            echo "Pipeline failed."
            echo "Please check Jenkins console logs."
        }

        always {
            cleanWs()
        }
    }
}
