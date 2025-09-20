# Prerequisites

1. Install node
2. Install gcloud cli
3. Install aws cli

*Setting up GLOUD CLI*
    2. Install Gcloud cli
    3. Allow scripts to run :  powershell --> Set-ExecutionPolicy (atleast on windows required)
    4. Run "gcloud auth application-default login" to get auth credentials
    5. Set the path to auth credentials to environment valiable as named "GOOGLE_APPLICATION_CREDENTIALS"
   
*Setting up AWS SAM / CLI*
    2. Create AWS role with policies( admin  for quick creation)
    3. Install AWS cli and configure for the role you made.
    4. Configure aws cli for your profile -> aws configure
    5. Check configuration details from aws console



