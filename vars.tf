# environment variables
variable "region" {
  description = "Region to create resources"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}
variable "environment" {
  description = "Project environment"
  type        = string
}
