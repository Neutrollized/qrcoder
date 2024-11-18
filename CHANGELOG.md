# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).


## [0.3.0] - 2024-11-18
### Added
- `options.defaultLogsBucketBehavior` to [store build logs in user-owned, regionalized bucket](https://cloud.google.com/build/docs/securing-builds/store-manage-build-logs)
### Changed
- Using Compute Engine default service account as Cloud Build service account as per [changes](https://cloud.google.com/build/docs/cloud-build-service-account-updates)
- Updated IAM to include new roles required for logging and building using new service account
- Updated base Docker image from `python:3.11-alpine` to `python:3.13-alpine`
- Updated Python package requirements: **Flask** from `3.0.2` to `3.0.3`, **validators** from `0.23.1` to `0.23.2`, and **pillow** from `10.2.0` to `10.4.0`
- Updated **google** and **google-beta** providers from `~> 4.0` to `~> 6.0`
### Fixed
- The `env` field within the Cloud Run deploy step was not being honored, and hence environment variables that are to be passed to the container will be done via `--set-env-vars` instead (part of `gcloud run deploy` option)

## [0.2.3] - 2024-03-24
### Added
- Footer in `index.html` with links to this repo and socials

## [0.2.2] - 2024-03-22
### Changed
- `index.html` page title updated from "App" to "Generator"
- Added handling of HTTP URLs

## [0.2.1] - 2024-03-21
### Added
- A proper README
- Added `description` to Terraform output values

## [0.2.0] - 2024-03-20
### Added
- `.idx` and various configuration files
- `terraform/` containing IaC code for provision GCP resources (GAR, GCS, Cloud Build trigger, etc.)
- `cloudbuild.yaml`
### Changed
- Re-organized files/folder structure
- Updated `Dockerfile`

## [0.1.0] - 2024-03-19
### Added
- Initial commit
