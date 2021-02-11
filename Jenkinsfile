node{
      def dockerImageName= 'anuragjain12/javadedockerapp_$JOB_NAME:$BUILD_NUMBER'
      stage('SCM Checkout'){
         git 'https://github.com/anuragjain12/java-groovy-docker'
      }
      stage('Build'){
         // Get maven home path and build
         //def mvnHome =  tool name: 'Maven 3.0.5', type: 'maven'   
         sh "mvn package -Dmaven.test.skip=true"
      }       
     
     stage ('Test'){
        // def mvnHome =  tool name: 'Maven 3.0.5', type: 'maven'    
         sh "mvn verify; sleep 3"
      }
      
     stage('Build Docker Image'){         
           sh "docker build -t ${dockerImageName} ."
      }  
   
      stage('Publish Docker Image'){
         withCredentials([usernamePassword(credentialsId: 'dockerpwdAnuragjain12', usernameVariable: 'USERNAME', passwordVariable: 'dockerPWD')]) {
              //sh "docker login -u jainanurag470 -p ${dockerPWD}"
               sh "docker login -u ${USERNAME} -p ${dockerPWD}"
         }
        sh "docker push ${dockerImageName}"
      }
      
     // withCredentials([string(credentialsId: 'dockerpwdAnuragjain12', variable: 'dockerPWD')]
    stage('Run Docker Image'){
            def dockerContainerName = 'javadockerapp_$JOB_NAME_$BUILD_NUMBER'
            def changingPermission='sudo chmod +x stopscript.sh'
            def scriptRunner='sudo ./stopscript.sh'           
            def dockerRun= "sudo docker run -p 8082:8080 -d --name ${dockerContainerName} ${dockerImageName}" 
            withCredentials([string(credentialsId: 'deploymentserverpwd', variable: 'dpPWD')]) {
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no jainanurag470@34.123.37.223" 
                  sh "sshpass -p ${dpPWD} scp -r stopscript.sh jainanurag470@52.76.172.196:/home/devops" 
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no jainanurag470@34.123.37.223 ${changingPermission}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no jainanurag470@34.123.37.223 ${scriptRunner}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no jainanurag470@34.123.37.223 ${dockerRun}"
            }
            
      
      }
      
         
  }
