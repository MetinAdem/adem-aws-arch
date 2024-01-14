variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC_cidr block"
  type        = string
}

variable "public-web-subnet-1-cidr" {
  default     = "10.0.1.0/24"
  description = "public_web_subnet1"
  type        = string
}

variable "public-web-subnet-2-cidr" {
  default     = "10.0.2.0/24"
  type        = string
}

variable "private-app-subnet-1-cidr" {
  default     = "10.0.3.0/24"
  type        = string
}

variable "private-app-subnet-2-cidr" {
  default     = "10.0.4.0/24"
  type        = string
}

variable "private-db-subnet-3-cidr" {
  default     = "10.0.5.0/24"
  type        = string
}

variable "private-db-subnet-4-cidr" {
  default     = "10.0.6.0/24"
  type        = string
}

variable "ssh-locate" {
  default     = "your_ip"
  type        = string
}

variable "database-instance-class" {
  default     = "db.t2.large"
  type        = string
}

variable "multi-az-deployment" {
  default     = false
  type        = bool
}