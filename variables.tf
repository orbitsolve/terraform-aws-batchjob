variable "lambda_name" {
  type = string
}

variable "lambda_source_file" {
  type = string
}

variable "lambda_layers" {
  type = list(string)
}

variable "schedule" {
  type = string
}

variable "lambda_env_vars" {
  type = map
}

variable "lambda_execution_role" {
  type = string
}

variable "tags" {
  type = map
}