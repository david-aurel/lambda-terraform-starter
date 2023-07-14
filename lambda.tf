# S3 to store the Javascript code for the lambda
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "${var.project_name}-lambda"
  force_destroy = true
}
resource "aws_s3_object" "lambda_object" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda.zip"
  source = "${path.module}/build/lambda.zip"
  etag   = filemd5("${path.module}/build/lambda.zip")
}


# Lambda that will run the Javascript code
resource "aws_lambda_function" "lambda_function" {
  function_name = var.project_name

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_object.key

  runtime = "nodejs18.x"
  handler = "build/index.handler"

  source_code_hash = filemd5("${path.module}/build/lambda.zip")

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
