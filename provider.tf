terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.28.0"
    }
  }
}

provider "google" {
  project = "terraform-455708"
  region      = "europe-west9"
  zone = "europe-west9-b"
  credentials = "./keys.json"
}
