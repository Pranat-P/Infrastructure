# Infrastructure

The Infrastructure repository holds the Terraform configuration files used to define and provision infrastructure components. These configurations are automatically deployed through GitHub Actions Workflow.

The directories in the root path of this repository correspond to the names of the different infrastructure clusters, making it easy to manage configurations for each cluster.  These directories contain Terraform .tf files applied to the respective cloud infrastructures.

**Example:**

    <cluster-name> (e.g., mycare-1)
    └── <cloud-provider-name> (e.g., aws, gcp, tm-cloud)
        └── <components-name> (e.g., eks, s3, vpc)
            ├── main.tf
            ├── variables.tf (optional)
            ├── outputs.tf (optional)
            └── (other Terraform configuration files)

## You can make cluster in two ways

### 1. using cli commands

- install terraform with 1.6.6 version
- install terragrunt with 0.54.21 version
- configure AWS profile using below command

      aws configure --profile <give_profilename_as_per_your_choice>
      export AWS_PROFILE=<profile_name>

- Then run below commands:

        terragrunt run-all init

    Above command will initialize working directory and also install plugins

        terragrunt run-all plan

    Above command will give preview that this much resources will create in your infrastructure.
    In simple terms it shows you that terraform will do before it actually does. you can catch error here

        terragrunt run-all apply

    Above command will create infrastructure or executes the actions proposed in terraform plan

### 2. using Github actions

- for that create branch from main
- Copy all modules, resources, outputs, variables, and variable values, and place them into their respective files. Then, update the variable values and module names as necessary in tfvars files
- first create vpc and then create eks
- when you create pull request you can see plan in comments in pull request
- when you merge in main terragrunt apply command will run and all the resources will created in your infrastructure.

## For destroy cluster

1. delete clusterrolebinding, serviceaccount and secrets from cluster through terraform
2. then delete all kubernetes resources from cluster through releases
3. then check for load-balancer from AWS UI, delete it if exists.
4. then delete eks modules and resources through terraform
5. then delete vpc through terraform
