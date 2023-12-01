// Glue catalog database
resource "aws_glue_catalog_database" "main_glue_database_dl" {
  name = "main-database-dl"
}

//Glue Crawler
resource "aws_glue_crawler" "main_crawler_dl" {
  database_name = aws_glue_catalog_database.main_glue_database_dl.name
  name          = "main-crawler-dl"
  role          = aws_iam_role.iam_main_role_glue.arn

  s3_target {
    path = "s3://${aws_s3_bucket.s3_bucket_dl.bucket}/processed"
  }
}

//Glue Job
resource "aws_glue_job" "main_glue_job_dl" {
  name     = "main-glue-job-dl"
  role_arn = aws_iam_role.iam_main_role_glue.arn
  glue_version = "4.0"

  command {
    python_version  = "3"
    script_location = "s3://${aws_s3_bucket.s3_bucket_dl.bucket}/source_code/test.py"
  }
}

//Glue Connection
resource "aws_glue_connection" "glue_connection_rds_instance" {
  name = "glue-connection-rds"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${aws_db_instance.rds_instance_main.endpoint}"
    USERNAME            = "exampleusername"
    PASSWORD            = var.pwd_rds_instance
  }
}

//Glue Workflow
resource "aws_glue_workflow" "main_glue_workflow_dl" {
  name = "main-glue-workflow-dl"
}

resource "aws_glue_trigger" "main_glue_trigger_start_dl" {
  name          = "trigger-start"
  type          = "ON_DEMAND"
  workflow_name = aws_glue_workflow.main_glue_workflow_dl.name

  actions {
    job_name = "main-crawler-dl"
  }
}

resource "aws_glue_trigger" "main_glue_trigger_inner_dl" {
  name          = "trigger-inner"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.main_glue_workflow_dl.name

  predicate {
    conditions {
      job_name = "main-crawler-dl"
      state    = "SUCCEEDED"
    }
  }

  actions {
    crawler_name = "main-glue-job-dl"
  }
}