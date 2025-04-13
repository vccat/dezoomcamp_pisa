terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.16.0"
    }
  }
}

provider "google" {

  project     = "dezoomcamp2025-448509"
  region      = "europe-west3"
}

resource "google_storage_bucket" "bucket_zoomcamp" {
  name          = "dezoomcamp2025-448509-bucket_fp"
  location      = "EU"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "dataset_final" {
  dataset_id                  = "dezoomamp_dataset_fp"  
  friendly_name               = "Dataset_final"  
  description                 = "This is the dataset used for zoomcamp final project development."
  location                    = "EU"     

  labels = {
    env = "zoomcamp"
  }
}

resource "google_bigquery_dataset" "dataset_final_prod" {
  dataset_id                  = "dezoomamp_dataset_pisa"  
  friendly_name               = "Dataset_pisa"  
  description                 = "This is the dataset used for zoomcamp final project production."
  location                    = "EU"     

  labels = {
    env = "zoomcamp"
  }
}

