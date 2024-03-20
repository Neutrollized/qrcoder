output "artifact_registry_id" {
  value = google_artifact_registry_repository.qrcoder_gar.id
}

output "bucket_name" {
  value = google_storage_bucket.qrcoder_gcs.name
}

output "service_account_email" {
  value = google_service_account.qrcoder_sa.email
}
