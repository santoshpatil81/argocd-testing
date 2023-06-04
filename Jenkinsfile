pipeline {
    agent any

    stages {
        stage('clone_git_repository') {
            steps {
                dir ('/tmp') {
                    checkout scmGit(
                        branches: [[name: 'master']],
                        userRemoteConfigs: [[url: 'https://github.com/open-policy-agent/conftest.git']]
                    )
                }
            }
        }
        stage('install_wget') {
            steps {
                sh "apt-get update && apt install wget"
            }
        }
        stage('download_conftest') {
            steps {
                script {
                    try {
                        sh "mkdir -p /tmp/conftest && wget -O /tmp/conftest.tar.gz 'https://github.com/open-policy-agent/conftest/releases/download/v0.42.1/conftest_0.42.1_Linux_x86_64.tar.gz'"
                    } finally {
                        sh "tar xvf '/tmp/conftest.tar.gz' -C /tmp/conftest"
                    }
                }
            }
        }
        stage('download_oras') {
            steps {
                script {
                    try {
                        sh "mkdir -p /tmp/oras && wget -O /tmp/oras/oras.tar.gz 'https://github.com/oras-project/oras/releases/download/v1.0.0/oras_1.0.0_linux_amd64.tar.gz'"
                    } finally {
                        sh "tar xvf '/tmp/oras/oras.tar.gz' -C /tmp/oras"
                    }
                }
            }
        }
        stage('download_policies') {
            steps {
                script {
                    try {
                        sh "mkdir -p /tmp/oras/policies && /tmp/oras/oras pull docker.io/santoshpatil81/policies:latest -p ."
                    } finally {
                        sh "ls -la /tmp/oras/policies"
                    }
                }
            }
        }
        stage('conftest_verify') {
            steps {
                script {
                    try {
                        sh "/tmp/conftest/conftest verify -p /tmp/oras/policies"
                    } finally {
                        sh "ls -la /tmp/oras/policies"
                    }
                }
            }
        }
        stage('run_conftest') {
            steps {
                script {
                    try {
                        sh "/tmp/conftest/conftest test /tmp/examples/kubernetes -p /tmp/oras/policies -o json >> /tmp/output.json"
                    } finally {
                        sh "cat /tmp/output.json"
                    }
                }
            }
        }
    }
}
