# QRCoder

Not happy with some of the options out there, I decided to make my own little app that can create QR codes for web URLs.


[Artifact Registry (GAR)](https://cloud.google.com/artifact-registry)

[Storage Bucket (GCS)](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)

[Cloud Build](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger)


## Setup
#### 0 - Enable Required APIs
You can do this via console or...
```console
gcloud services enable --async \
  artifactregistry.googleapis.com \
  run.googleapis.com \
  storage.googleapis.com \
  cloudbuild.googleapis.com
```

#### 1 - Connect Repository
Unless you're using [Cloud Source Repository](https://cloud.google.com/source-repositories/docs) to host your code, you will have to first [connect your GitHub repository](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github) to GCP Cloud Build otherwise you may get an error similar to the following:
```
Error 400: Repository mapping does not exist. Please visit https://console.cloud.google.com/cloud-build/triggers/connect?project=01234567890 to connect a repository to your project
```

#### 2 - Deploy Resources
Whether you plan to run this locally or deploy to Cloud Run, it still needs a GCS bucket.  Deploying the resources in the `terraform/` directory will deploy all of this.  Optionally, you can just deploy the bucket manually via `gcloud` or Google Cloud console. 


## Local Testing
```console
python -m venv .venv
source venv/bin/activate
pip install -r requirements.txt
```

`export QRCODER_GCS_BUCKET='[YOUR_GCS_BUCKET]' and then exec `devserver.sh` to run the app locally.  You can then access it locally at **http://127.0.0.1:80** (or whatever you set the `--host` and `--port` values to)
