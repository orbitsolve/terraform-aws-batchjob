output "lambda_arn" {
  value = aws_lambda_function.batchjob_lambda_function.arn
}

output "iam_role_arn" {
  value = var.lambda_execution_role
}
