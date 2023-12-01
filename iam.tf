locals {
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          Action : "sts:AssumeRole",
          Principal : {
            "Service" : "glue.amazonaws.com"
          },
          Effect : "Allow"
        }
      ]
    }
  )
  assume_role_policy_cognito = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          Effect : "Allow",
          Principal : {
            "Service" : "cognito-idp.amazonaws.com"
          },
          Action : "sts:AssumeRole"
        }
      ]
    }
  )
}

// IAM GLUE

resource "aws_iam_role" "iam_main_role_glue" {
  assume_role_policy = local.assume_role_policy
  name               = "main-role-glue"
}

resource "aws_iam_role_policy" "this" {
  role = aws_iam_role.iam_main_role_glue.id
  name = "main-role-policy-glue"
  policy = jsonencode(

    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "glue:*",
            "s3:GetBucketLocation",
            "s3:ListBucket",
            "s3:ListAllMyBuckets",
            "s3:GetBucketAcl",
            "ec2:DescribeVpcEndpoints",
            "ec2:DescribeRouteTables",
            "ec2:CreateNetworkInterface",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeSubnets",
            "ec2:DescribeVpcAttribute",
            "iam:ListRolePolicies",
            "iam:GetRole",
            "iam:GetRolePolicy",
            "cloudwatch:PutMetricData"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:CreateBucket",
            "s3:PutBucketPublicAccessBlock"
          ],
          "Resource" : [
            "arn:aws:s3:::aws-glue-*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource" : [
            "arn:aws:s3:::aws-glue-*/*",
            "arn:aws:s3:::*/*aws-glue-*/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject"
          ],
          "Resource" : [
            "arn:aws:s3:::crawler-public*",
            "arn:aws:s3:::aws-glue-*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:AssociateKmsKey"
          ],
          "Resource" : [
            "arn:aws:logs:*:*:log-group:/aws-glue/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:CreateTags",
            "ec2:DeleteTags"
          ],
          "Condition" : {
            "ForAllValues:StringEquals" : {
              "aws:TagKeys" : [
                "aws-glue-service-resource"
              ]
            }
          },
          "Resource" : [
            "arn:aws:ec2:*:*:network-interface/*",
            "arn:aws:ec2:*:*:security-group/*",
            "arn:aws:ec2:*:*:instance/*"
          ]
        }
      ]
    }
  )
}

// IAM COGNITO

resource "aws_iam_role" "iam_main_role_cognito" {
  assume_role_policy = local.assume_role_policy_cognito
  name               = "main-role-cognito"
}

resource "aws_iam_role_policy" "this_cognito" {
  role = aws_iam_role.iam_main_role_cognito.id
  name = "main-role-policy-cognito"
  policy = jsonencode(

    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sns:Publish"
          ],
          "Resource" : [
            "*"
          ]
        }
      ]
    }
  )
}