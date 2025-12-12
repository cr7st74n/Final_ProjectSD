pipeline {
    agent any

    environment {
        // Git repo with your Spring Boot project
        GIT_REPO_URL = 'https://github.com/cr7st74n/Final_ProjectSD.git'

        // Nexus inside the cluster
        NEXUS_URL  = 'http://nexus-service:8081'
        NEXUS_REPO = 'maven-releases'   // or the repo name you created in Nexus

        // For homework you can hardcode admin creds.
        // In real life: use Jenkins credentials.
        NEXUS_USER = 'admin'
        NEXUS_PASS = '1214'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO_URL}", branch: 'main'
            }
        }

        stage('Build JAR with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Upload JAR to Nexus') {
            steps {
                script {
                    // Find the JAR that was built
                    def jarFile = sh(
                        script: "ls target/*.jar | head -n 1",
                        returnStdout: true
                    ).trim()

                    echo "Uploading ${jarFile} to Nexus..."

                    sh """
                    curl -v -u ${NEXUS_USER}:${NEXUS_PASS} --upload-file ${jarFile} \
                      ${NEXUS_URL}/repository/${NEXUS_REPO}/$(basename ${jarFile})
                    """
                }
            }
        }
    }
}

