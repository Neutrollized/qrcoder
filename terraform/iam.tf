resource "google_service_account" "qrcoder_sa" {
  account_id   = "qrcoder-app-sa"
  display_name = "QRCoder app service account"
}

resource "google_storage_bucket_iam_binding" "bucket_iam_bucket_reader" {
  bucket = google_storage_bucket.qrcoder_gcs.name
  role   = "roles/storage.legacyBucketReader"
  members = [
    "serviceAccount:${google_service_account.qrcoder_sa.email}",
  ]
}

resource "google_storage_bucket_iam_binding" "bucket_iam_object_admin" {
  bucket = google_storage_bucket.qrcoder_gcs.name
  role   = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${google_service_account.qrcoder_sa.email}",
  ]
}


#-------------------------------
# Cloud Build service account
#-------------------------------
resource "google_project_iam_member" "builder" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "act_as" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "gcs_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}
