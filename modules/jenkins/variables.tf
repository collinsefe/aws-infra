variable "my_public_subnets" {
  description = "Public Subnets"
  type        = list(any)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 4 && substr(var.vpc_id, 0, 4) == "vpc-"
    error_message = "VPC ID must not be empty."
  }
}

variable "user_data" {
  type = string
  
}

variable "ingress_rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}