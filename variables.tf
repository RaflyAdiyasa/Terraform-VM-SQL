variable "gcp_svc_key" {

}

variable "project_id" {
  description = "GCP Project ID"
  type        = string

}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"

}
variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"

}
variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "vm-instance-sql-tf-2"

}
variable "machine_type" {
  description = "Machine type for the VM instance"
  type        = string
  default     = "e2-medium"

}
variable "disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 10

}
variable "disk_type" {
  description = "Type of the boot disk"
  type        = string
  default     = "pd-balanced"

}
variable "image" {
  description = "Image for the boot disk"
  type        = string
  default     = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250415"

}
variable "tags" {
  description = "Network tags for the VM instance"
  type        = list(string)
  default     = ["http-server", "https-server", "allow-mysql"]

}
variable "metadata_startup_script" {
  description = "Startup script for the VM instance"
  type        = string
  default     = "startup-script.sh"

}