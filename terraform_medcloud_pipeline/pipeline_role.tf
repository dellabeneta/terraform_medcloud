resource "aws_iam_role" "pipeline_role" {
  name = "medcloud-cp-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

data "aws_iam_policy_document" "pipeline_policies" {
  statement {
    sid       = ""
    actions   = ["codestar-connections:UseConnection"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid       = ""
    actions   = ["cloudwatch:*", "s3:*", "codebuild:*"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "pipeline_policy" {
  name        = "medcloud-pipeline-policy"
  path        = "/"
  policy      = data.aws_iam_policy_document.pipeline_policies.json
}

resource "aws_iam_role_policy_attachment" "pipeline_attachment" {
  policy_arn = aws_iam_policy.pipeline_policy.arn
  role       = aws_iam_role.pipeline_role.id
}
