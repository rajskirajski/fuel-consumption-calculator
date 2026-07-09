variable "project_name" {
  type        = string
  description = "Project name."
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags."
}
