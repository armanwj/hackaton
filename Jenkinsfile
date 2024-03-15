pipeline {
  agent any
  environment {
        IMAGE_REPO_NAME="frontend_angular"
        IMAGE_TAG="v1"
        AWS_DEFAULT_REGION="us-east-1"
        AWS_ACCOUNT_ID="992382586240"
        REPOSITORY_URI="992382586240.dkr.ecr.us-east-1.amazonaws.com/hackaton"
  }
  stages {
    stage("BUILD DOCKER IMAGE") {
      steps {
        script {
          dockerImageBuild = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
     stage("DEPLOY DOCKER") {
       steps {
          
//           sh """aws ecr get-login-password | docker login --username AWS --password-stdin ${REPOSITORY_URI}"""
          sh """docker login -u AWS -p $(aws ecr get-login-password --region ${AWS_DEFAULT_REGION}) ${REPOSITORY_URI}"""
          sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"""
          sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
      }
   }
    stage("DEPLOY & ACTIVATE") {
      steps {
        sh """aws ecs run-task --cluster Cluster --count 1 --launch-type FARGATE --task-definition frontend_angular --network-configuration "awsvpcConfiguration={subnets=[subnet-0e2677a0a337e894a
],securityGroups=[sg-0f1f0f22dad4beb24],assignPublicIp=ENABLED}"
"""
      }
    }
  }
}
