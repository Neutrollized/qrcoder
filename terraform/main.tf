data "google_project" "project" {
  project_id = var.project_id
}

resource "random_id" "name_suffix" {
  byte_length = 4
}


#---------------------------
# Artifact Registry
#---------------------------
resource "google_artifact_registry_repository" "qrcoder_gar" {
  location      = var.region
  repository_id = var.gar_repo_name
  description   = "Docker GAR - Terraform managed"
  format        = "DOCKER"
}


#--------------------
# GCS
#--------------------
resource "google_storage_bucket" "qrcoder_gcs" {
  name          = "${var.bucket_name}-${random_id.name_suffix.hex}"
  storage_class = var.storage_class
  location      = var.location
  force_destroy = var.force_destroy

  # I didn't want to make the bucket itself public
  # and opted to for the ability to make objects in it public instead 
  uniform_bucket_level_access = false

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "Delete"
    }
  }
}


#---------------------------
# Cloud Build
#---------------------------
resource "google_cloudbuild_trigger" "docker_build_trigger" {
  name        = "qrcoder-cloudrun-build-and-deploy"
  description = "QRCoder Build and Deploy - Terraform managed"

  filename = "cloudbuild.yaml"

  github {
    owner = var.github_repo_owner
    name  = var.github_repo_name
    push {
      branch = "^(main|master)$"
    }
  }

  substitutions = {
    _GAR_REGION            = var.region
    _GAR_REPO_NAME         = var.gar_repo_name
    _GCS_BUCKET_NAME       = google_storage_bucket.qrcoder_gcs.name
    _REGION                = var.cloudrun_region
    _SERVICE_ACCOUNT_EMAIL = google_service_account.qrcoder_sa.email
    _SERVICE_NAME          = var.cloudrun_service_name
    _INGRESS               = var.cloudrun_ingress
    _EXECUTION_ENVIRONMENT = var.cloudrun_exec_env
  }

  approval_config {
    approval_required = var.trigger_approval_required
  }
}
