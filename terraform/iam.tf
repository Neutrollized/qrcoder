resource "google_service_account" "qrcoder_sa" {
  account_id   = "qrcoder-app-sa"
  display_name = "QRCoder app service account"
}

resource "google_storage_bucket_iam_binding" "bucket_iam_binding" {
  bucket = google_storage_bucket.qrcoder_gcs.name
  role   = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${google_service_account.qrcoder_sa.email}",
  ]
}


#-------------------------------
# Cloud Build service account
#-------------------------------
resource "google_project_iam_member" "iam_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "iam_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}
