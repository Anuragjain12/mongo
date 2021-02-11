node{
      def dockerImageName= 'anuragjain12/mongo_$JOB_NAME:$BUILD_NUMBER'
      stage('SCM Checkout'){
         git 'https://github.com/anuragjain12/mongo'
      }
      //stage('Build'){
         // Get maven home path and build
         //def mvnHome =  tool name: 'Maven 3.0.5', type: 'maven'   
         //sh "mvn package -Dmaven.test.skip=true"
      //}       
     
     //stage ('Test'){
        // def mvnHome =  tool name: 'Maven 3.0.5', type: 'maven'    
         //sh "mvn verify; sleep 3"
      //}
      
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
            def dockerContainerName = 'mongo_$JOB_NAME_$BUILD_NUMBER'
            //def changingPermission='sudo chmod +x stopscript.sh'
            //def scriptRunner='sudo ./stopscript.sh'           
            def dockerRun= "sudo docker run -p 27017:27017 -d --name ${dockerContainerName} ${dockerImageName}" 
            //withCredentials([string(credentialsId: 'deploymentserverpwd', variable: 'dpPWD')]) 
            withCredentials([usernamePassword(credentialsId: 'test123456', usernameVariable: 'USERNAME', passwordVariable: 'dpPWD')]){
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ${USERNAME}@35.202.164.184" 
                  sh "sshpass -p ${dpPWD} scp -r stopscript.sh ${USERNAME}@35.202.164.184:/home/devops" 
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ${USERNAME}@35.202.164.184 ${changingPermission}"
                  //sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ${USERNAME}@35.202.164.184 ${scriptRunner}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ${USERNAME}@35.202.164.184 ${dockerRun}"
            }
            
      
      }
      
         
  }
