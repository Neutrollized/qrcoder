output "bucket_name" {
  value       = google_storage_bucket.qrcoder_gcs.name
  description = "Name of the GCS bucket used to store the QR codes."
}

output "service_account_email" {
  value       = google_service_account.qrcoder_sa.email
  description = "GCP service account associated with the Cloud Run service."
}
