pipeline{
	agent any
	environment{
		registry = 'himanshuchaudhary/angular-app'
	}
	stages{
		stage('initialize npm'){
			steps{
				sh "npm install"
				sh "npm install @angular/cli"
			}
		}

		stage('build'){
			steps{
				sh "npm run build --prod"
			}
		}

		stage('build-image'){
			when{
				branch 'master'
			}
			steps{
				script{
            		dockerImage = docker.build("${registry}:$BUILD_NUMBER")
            		docker.withRegistry( '','docker-hub'){
            		dockerImage.push()
          		}
	    	}
				sh 'docker rmi $registry:$BUILD_NUMBER'
			}
		}
		stage('deploy to production'){
			when{
				branch 'master'
			}
			steps{
				withKubeConfig(
            		clusterName: 'gke_resounding-sled-291408_us-central1-c_cluster-1', contextName: 'gke_resounding-sled-291408_us-central1-c_cluster-1', credentialsId: 'kube-config', namespace: 'capstone') {
            			sh "cat Deployment.yml | sed 's/angular-app:5/angular-app:$BUILD_NUMBER/' | kubectl apply -f -"
				}
			}
		}
	}	
	post{
		success{
			cleanWs()
		}
		failure{
			emailext ( 
				subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!!', 
				body: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:Check console output at $BUILD_URL to view the results.',
				to : 'himanshuchaudhary426@gmail.com',
				attachLog: true
			)
		}
	}
}