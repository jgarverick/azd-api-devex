# Input variables for the module

variable "location" {
  description = "The supported Azure location where the resource deployed"
  type        = string
}

variable "environment_name" {
  description = "The name of the azd environment to be deployed"
  type        = string
}

variable "tags" {
  description = "The tags to associate with your resources"
  type        = map(string)
  default = {
    "deployer" = "jgarverick"
  }

}
