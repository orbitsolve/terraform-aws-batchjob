data "archive_file" "python_lambda_package_batchjob" {
  type        = "zip"
  source_file = var.lambda_source_file
  output_path = "${var.lambda_name}-Lambda.zip"
}

resource "aws_lambda_function" "batchjob_lambda_function" {
  function_name    = var.lambda_name
  filename         = "${var.lambda_name}-Lambda.zip"
  source_code_hash = data.archive_file.python_lambda_package_batchjob.output_base64sha256
  role             = var.lambda_execution_role
  runtime          = (var.lambda_language == "python") ? "python3.9" : "nodejs16.x"
  handler          = (var.lambda_language == "python") ? "lambda_function.lambda_handler" : "index.hanlder"
  timeout          = var.lambda_timeout

  layers = var.lambda_layers

  environment {
    variables = var.lambda_env_vars
  }

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "batchjob_event_rule" {
  name                = "run-lambda-${var.lambda_name}"
  description         = "Schedule to run lambda in every 5 minutes"
  schedule_expression = var.schedule
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "lambda_function_target_batchjob" {
  target_id = "lambda-function-target-${var.lambda_name}"
  rule      = aws_cloudwatch_event_rule.batchjob_event_rule.name
  arn       = aws_lambda_function.batchjob_lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_batchjob" {
  statement_id  = "AllowExecutionFromCloudWatch-${var.lambda_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.batchjob_lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.batchjob_event_rule.arn
}
