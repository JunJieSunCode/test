pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/your-username/your-repo.git' // GitHub 仓库地址
        SSH_CREDENTIALS = '7a940e18-28be-471f-b2cc-9d3cdd4b2975' // Jenkins SSH 凭证ID
        REMOTE_SERVER = 'root@122.51.254.112' // 远程服务器登录信息
        DOCKER_IMAGE = 'your-app:latest' // Docker 镜像名称
    }

    stages {
        stage('Checkout Code') {
            steps {
                // 从 GitHub 拉取代码
                git url: "${GIT_REPO}", branch: 'main'
            }
        }

        stage('Build JAR') {
            steps {
                // 使用 Maven 构建 JAR 包
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    // 通过 SSH 将项目传输到远程服务器并构建 Docker 镜像
                    sshagent (credentials: ["${SSH_CREDENTIALS}"]) {
                        sh """
                        scp -r . ${REMOTE_SERVER}:/path/to/remote/app
                        ssh ${REMOTE_SERVER} '
                        cd /path/to/remote/app &&
                        docker build -t ${DOCKER_IMAGE} .
                        docker run -d --name your-app-container -p 8888:8888 ${DOCKER_IMAGE}
                        '
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            // 清理 Jenkins 工作区
            cleanWs()
        }
    }
}
