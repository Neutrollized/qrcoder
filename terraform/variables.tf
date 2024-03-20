#-----------------------
# provider variables
#-----------------------
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy GCP resources"
  type        = string
  default     = "us-east4"
}


#-------------------------
# Artifact Registry
#-------------------------
variable "gar_repo_name" {
  description = "Google Artifact Registry repo name."
  type        = string
  default     = "qrcoder-docker-repo"
}


#-------------------------
# GCS
#-------------------------
variable "bucket_name" {
  description = "Name of GCS bucket that will serve as Vault's backend"
  type        = string
  default     = "qrcoder-app-storage"
}

variable "storage_class" {
  description = "Storage class, options are: STANDARD, MULTI_REGIONAL, REGIONAL.  There are other options, but you shouldn't be using those for Vault backend."
  type        = string
  default     = "REGIONAL"

  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL"], var.storage_class)
    error_message = "Accepted values are STANDARD, MULTI_REGIONAL or REGIONAL"
  }
}

variable "location" {
  description = "Multi-region name, options are: ASIA, EU, US"
  type        = string
  default     = "us-east4"
}

variable "force_destroy" {
  description = "Force destroy the GCS bucket even if it's not empty"
  type        = bool
  default     = true
}


#-------------------------
# Cloud Build
#-------------------------
variable "github_repo_owner" {
  description = "GitHub repo owner name (user or organization)"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repo name.  Not the full URI."
  type        = string
}

variable "cloudrun_service_name" {}

variable "cloudrun_ingress" {
  description = "Set ingress traffic sourcess allowed to call the service.  Options are: 'all', 'internal', 'internal-and-cloud-load-balancing'"
  type        = string
  default     = "all"

  validation {
    condition     = contains(["all", "internal", "internal-and-cloud-load-balancing"], var.cloudrun_ingress)
    error_message = "Accepted values are all, internal or internal-and-cloud-load-balancing"
  }
}

variable "cloudrun_region" {
  description = "Region where Cloud Run is deployed.  This may be different from the region due to the some feastures (i.e. custom domains) that are still in beta and not support everywhere yet."
  type        = string
  default     = "us-east4"
}

variable "cloudrun_exec_env" {
  description = "Set execution environment for Cloud Run.  Options are: 'gen1', 'gen2'"
  type        = string
  default     = "gen1"

  validation {
    condition     = contains(["gen1", "gen2"], var.cloudrun_exec_env)
    error_message = "Accepted values are gen1 or gen2"
  }
}

variable "trigger_approval_required" {
  description = "Require approval before build executes"
  type        = bool
  default     = true
}
