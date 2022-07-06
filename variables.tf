variable "prefix" {
  type        = string
  description = "A prefix for the resource names, this helps create multiple instances of this stack for different environments and regions"
  default     = ""
}

variable "schedule" {
  type        = string
  description = "Schedule expression for running the cleanup function"
  default     = "cron(0 3 * * ? *)"
}

variable "sns_alert" {
  type        = string
  description = "SNS topic ARN to send failure alerts to"
  default     = ""
}

variable "es_endpoint" {
  type        = string
  description = "The elasticsearch endpoint"
}

variable "index" {
  type        = string
  description = "Prefix of the index names. e.g. logstash if your indices look like logstash-2017.10.30"
}

variable "delete_after" {
  type        = number
  default     = 7
  description = "How many days old to keep"
}

variable "index_format" {
  type        = string
  description = "Variable section of the index names. e.g. %Y.%m.%d if you indices look like logstash-2017.10.30"
}

variable "python_version" {
  type        = string
  default     = "2.7"
  description = "Python version to be used"
}
