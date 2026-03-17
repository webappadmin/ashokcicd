pipeline {
    agent any

    environment {
        TF_VAR_subscription_id = credentials('AZ_SUBSCRIPTION_ID')
        TF_VAR_client_id       = credentials('AZ_CLIENT_ID')
        TF_VAR_client_secret   = credentials('AZ_CLIENT_SECRET')
        TF_VAR_tenant_id       = credentials('AZ_TENANT_ID')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Approve Terraform Apply?'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}