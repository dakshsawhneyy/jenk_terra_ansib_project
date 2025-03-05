terraform{
    backend "s3" {
        bucket = "devops_project_bucket-23"
        key = "terraform/statefile.tfstate"    # defines the file path inside the S3 bucket where Terraform will store the state file.
        region = "ap-south-1"
    }
}
