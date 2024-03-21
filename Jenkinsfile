pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-2"
    }
    tools {nodejs "node"}
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                   checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/7hundredtech/jenkins-eks-terraform-cicd.git']])
                }
            }
        }
        
        stage('Build image') {
            steps {
              script{
                  sh 'docker build -t ojosamuel/nodejs-webapp .'
                }
             
            }
        }  
        stage('Push image to Dockerhub') {
            steps {
              script{
               withCredentials([string(credentialsId: 'dockerpassword', variable: 'dockerpassword')]) {
                sh 'docker login --username ojosamuel --password ${dockerpassword}'
}
                 
                }  
                 sh 'docker push ojosamuel/nodejs-webapp '
                }
             
            }
        
        stage('Terraform Script'){
            steps{
                script{
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply --auto-approve'
                    }
                
                }

            }
        
       
        stage('Deploying  Application') {
            steps{
                script{
                    dir('modules/eks/k8manifestfiles') {
                        sh ('aws eks update-kubeconfig --region us-east-2 --name myeks-cluster')
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                        
                        
                    }
                }
            }
        }
    }
}


