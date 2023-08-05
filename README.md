
## Cloud Native App using Flask, EKS and Terraform.

This is a simple monitoring application built on flask. The application is deployed on **AWS EKS** and the infrastructure including the EKS is built by using **Terraform**.

### Prerequisite of creating this setup are:-
1. Programmatic access to AWS (Access Key and Secret Access key)
2. Basic understanding of AWS EKS
3. Basic understanding of FLASK 
4. Basic understanding of Docker and Kubernetes
5. Basic understanding of terraform
6. AWS CLI 
7. Kubernetes CLI


Before starting to build the project please set up the aws credentials and region using ```aws configure``` command. Make sure aws-cli is installed on your system.

### Component of the projects.

1. **infrastructure-as-code** is the directory where HCL files are present to provision infrastructure required to build this project. Inside this directory run the below commands to spin up the infrastructure.

Make sure the terraform is installed in your system. [Download Terraform](https://developer.hashicorp.com/terraform/downloads)

To initialize the terraform and download the necessary providers

        terraform init

To view the plan for creating the infrastructure

        terraform plan

To create the infrastructure

        terraform apply

The apply command will take 15-20 mins to complete. Please wait.

#### Note:- I've used region us-west-2 as my default region if you want to use a different region you have to change it in variables.tf file.


2. **native-app** is the directory where the webapp code and Dockerfile to build the image of the code is placed.
Run the command inside the native-app directory to create an image of your webapp from the Dockerfile (make sure you have the Docker installed and running to make the below command work).
    
        docker build -t native-app .

    OR if you are working in MacOS with silicon chip (M series) run the below command to change the platform during the docker build:-
        
        docker build -t native-app . --platform linux/amd64

    After the above command successfully completed you should see your image(native-app) listed under the output of:-

        docker images

During the first step we are also creating a AWS Elastic Container Repository name **my-first-ecr-repo** and now we will push our image built in last step to that repository.
On your AWS account go to your ECR section and search for **my-first-ecr-repo** repo. Click on it and on the top right corner there is a button **View Push Command**, click on it and follow the steps. We don't have to create the image again since we already did that we only have to tag and push it to the repository.

First you have to login to the ECR via console. The command will look something this where you credentials will be provided. Please copy paste from the AWS ECR console to get the correct command according to your account credentials.

        aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com

Then we have to tag the image and the command will look something like: -

        docker tag native-app aws_account_id.dkr.ecr.us-west-2.amazonaws.com/my-repository:tag

Finally, we have to push the image to the ECR and the command for it will look something like this: -

        docker push aws_account_id.dkr.ecr.us-west-2.amazonaws.com/my-repository:tag

3. **k8s** this directory contains all the kubernetes manifest file and using this we will deploy our app and create a public load balancer to access our app from the internet.

Edit the deployment.yml to provide your image url in the pod template.

During our first step we've created a Elastic Kubernetes Service and now we will connect our local terminal session to it. Make sure kubectl is installed in your system for the below commands to work.

To connect to AWS EKS run the below command (mention you own region which you have use in terraform): -

        aws eks --region us-west-2a update-kubeconfig --name cloud-native-cluster

To check whether you are successfully connected to your EKS cluster you can run any kubernetes command for e.g. to check nodes run: -

        kubectl get nodes

The above command should return you the worker node of the cluster (in our case 1 only).

After successfully connecting to the EKS deploy your app using: -

        kubectl apply -f deployment.yml

Once deployment is created check your deployment status using

        kubectl get deployments

When the pods in the deployment is in running state then create a public load balancer using: -

        kubectl apply -f public-lb.yml

The load balancer will take 3-5 mins to start working and after use the below command to get the url to access your app: -

        kubectl get svc -o wide

Use the public IP/url visible in above command's output and check in browser if you can access your app.

#### Note:- The infrastructure used in this project does not come under free tier and will incur some charges so please don't forget to destroy your project using ```terraform destroy``` once done.