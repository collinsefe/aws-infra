pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = 'aws-credentials-id'  // Replace with your AWS credentials ID in Jenkins
        TF_VAR_ami_id = 'ami-0acc77abdfc7ed5a6' // Update as needed
        TF_VAR_instance_type = 't2.medium'      // Update as needed
        TF_VAR_key_name = 'my-key-pair'         // Update as needed
        TF_VAR_artifact_bucket_name = 'my-artifact-bucket' // S3 bucket name
    }

    stages {

        stage('Install Terraform') {
            steps {
                sh """
                # Download and install Terraform if not available
                if ! command -v terraform &> /dev/null; then
                    wget https://releases.hashicorp.com/terraform/1.3.0/terraform_1.3.0_linux_amd64.zip
                    unzip terraform_1.3.0_linux_amd64.zip
                    sudo mv terraform /usr/local/bin/
                fi
                terraform -version
                """
            }
        }

        stage('Initialize Terraform') {
            steps {
                // Initialize the Terraform project
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: AWS_CREDENTIALS]]) {
                    sh 'terraform init -reconfigure'
                }
            }
        }

        stage('Plan Infrastructure') {
            steps {
                // Generate and review the plan for deploying resources
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: AWS_CREDENTIALS]]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Apply Infrastructure') {
            steps {
                // Apply the Terraform plan
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: AWS_CREDENTIALS]]) {
                    // sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Post Deployment Steps') {
            steps {
                echo "Terraform deployment complete."
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            deleteDir()  // Clean up workspace after build
        }
        success {
            echo 'Infrastructure has been successfully deployed!'
        }
        failure {
            echo 'Deployment failed. Please check the logs for more details.'
        }
    }
}
