resource "aws_codebuild_project" "codebuild_project" {
  name         = "medcloud-codebuild-project"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec.yml")
  }
}


resource "aws_codepipeline" "code_pipeline" {

  name     = "medcloud-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.bucket_artifacts.id
  }


    stage {
        name = "Source"
        action {
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeStarSourceConnection"
            output_artifacts = ["tf-code"]
            version = "1"
                        
                configuration = {
                    ConnectionArn = "arn:aws:codestar-connections:us-east-1:533084366484:connection/15d3a770-64ce-4122-b80d-3ecb030f40a8"
                    FullRepositoryId = "Dellabeneta/terraform_medcloud_infra"
                    BranchName = "master"
                }
        }
    }

    stage {
        name = "Build"
        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            region = "us-east-1"
            input_artifacts  = ["tf-code"]
            version          = "1"

                configuration = {
                    ProjectName = "medcloud-codebuild-project"
                }
        }
    }
}

# bucket para backend dos artefatos gerados no pipeline
resource "aws_s3_bucket" "bucket_artifacts" {
  bucket = "medcloud-backend-artifacts" 
  force_destroy = true
}

resource "aws_s3_bucket_acl" "bucket_artifacts_acl" {
  bucket = aws_s3_bucket.bucket_artifacts.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_artifacts_versioning" {
  bucket = aws_s3_bucket.bucket_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}