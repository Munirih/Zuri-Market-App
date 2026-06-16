
variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
}

variable "api_secret_key" {
  description = "API key"
  type        = string
  sensitive   = true
}


variable "store_name" {
  description = "Store name"
  type        = string
}

