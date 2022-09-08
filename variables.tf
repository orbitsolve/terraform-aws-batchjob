variable "lambda_name" {
  type = string
}

variable "lambda_source_file" {
  type = string
}

variable "lambda_language" {
  type = string
  default = "python"
}

variable "lambda_timeout" {
  type = number
  default = 180
}

variable "lambda_layers" {
  type = list(string)
}

variable "schedule" {
  type = string
}

variable "lambda_env_vars" {
  type = map(any)
}

variable "lambda_execution_role" {
  type = string
}

variable "tags" {
  type = map(any)
}
