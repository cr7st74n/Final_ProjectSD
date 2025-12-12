pipeline {
    agent any

    environment {
        // Your GitHub repo
        GIT_REPO_URL = 'https://github.com/cr7st74n/Final_ProjectSD.git'

        // Nexus inside Kubernetes
        NEXUS_URL  = 'http://nexus-service:8081'
        NEXUS_REPO = 'maven-releases'   // make sure this repo exists in Nexus

        // For homework you can hardcode. In real life, use Jenkins credentials.
        NEXUS_USER = 'admin'
        NEXUS_PASS = '1214'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO_URL}", branch: 'main'
            }
        }

        stage('Build JAR with Maven Wrapper') {
            steps {
                sh '''
                  echo ">>> Using Maven Wrapper to build the JAR..."
                  chmod +x mvnw
                  ./mvnw clean package -DskipTests
                '''
            }
        }

        stage('Upload JAR to Nexus') {
            steps {
                script {
                    def jarFile = sh(
                        script: "ls target/*.jar | head -n 1",
                        returnStdout: true
                    ).trim()

                    def fileName = jarFile.tokenize('/').last()
                    echo "Uploading ${jarFile} to Nexus as ${fileName}..."

                    sh """
                      curl -v -u ${NEXUS_USER}:${NEXUS_PASS} --upload-file ${jarFile} \
                        ${NEXUS_URL}/repository/${NEXUS_REPO}/${fileName}
                    """
                }
            }
        }
    }
}

