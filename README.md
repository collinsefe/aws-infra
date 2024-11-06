# AWS Infrastructure with Terraform Modules
This Terraform configuration uses modularized code to provision and manage AWS resources, including EC2 instances, ECS clusters, ECR repositories, and an S3 bucket for artifact storage. 

Each resource is encapsulated in its own Terraform module, making the codebase modular and reusable.

### Requirements
**Terraform**: Version 1.3 or later is required. Download it from terraform.io.

**AWS Account**: Ensure you have access to an AWS account and credentials configured with sufficient permissions to create the required resources.

**Terraform AWS Provider**: Version 4.0 or later.

### Modules
The configuration uses the following custom Terraform modules:

### EC2 Module (modules/ec2)

Provisions an EC2 instance with the specified AMI, instance type, and key pair.

Additional configurations like user data can be provided.

### ECR Module (modules/ecr)

Creates Elastic Container Registry (ECR) repositories for different environments (dev and test).

### ECS Module (modules/ecs)

Provisions ECS clusters for dev and test environments with related services, task definitions, and application load balancers.

### S3 Module (modules/s3)

Creates an S3 bucket used for storing artifacts.

### File Structure
The repository has the following structure:

``` plaintext
.
├── main.tf                 # Main Terraform configuration
├── modules
│   ├── ec2                 # EC2 module for provisioning EC2 instances
│   ├── ecr                 # ECR module for creating repositories
│   ├── ecs                 # ECS module for clusters, services, and load balancers
│   └── s3                  # S3 module for artifact storage
└── README.md               # Project documentation

```

## Usage
Clone the Repository:

```bash
git clone <repository-url>
cd <repository-directory>
```

**Initialize Terraform**: Run the following command to initialize the project and download provider and module dependencies:

```bash
terraform init
```

**Set Variables**: Define any required variables in a variables.tf file or pass them via the CLI. 

Examples include:

```bash
ami_id
instance_type
key_name
artifact_bucket_name
```

**Apply the Configuration**: Apply the configuration to create resources in AWS:

```bash
terraform apply
```

Review the output plan and type **yes** to confirm.

**Resource Outputs**: After applying, Terraform will output useful information like the repository URLs, load balancer DNS names, and S3 bucket names.

### Modules Overview
Each resource module has specific input parameters, enabling custom configuration per environment.

### EC2 Instance
The ec2 module provisions an EC2 instance with specified AMI, instance type, and SSH key pair, along with user data for initialization.

### ECR Repository
The ecr module creates an ECR repository for both the dev and test environments, enabling container image storage and versioning.

### ECS Cluster
The ecs module provisions ECS clusters and associated resources, such as:

**Cluster Name**: Unique per environment.

**ECR Repository URL**: Links to the environment-specific ECR repository.

**Application Load Balancer:** Configured for each environment for load distribution.

**Service and Task Definitions:** Deploy and manage services.

### S3 Bucket
The s3 module creates an S3 bucket for artifact storage.

### Cleanup
To remove all created resources, run:

```bash
terraform destroy
```

### Additional Notes
**IAM Roles and Policies:** Ensure any required IAM roles and policies for ECS and EC2 permissions are configured.

**Networking Configuration:** Check VPC and subnet settings for compatibility with ECS and EC2.

### License
This project is licensed under the MIT License.
