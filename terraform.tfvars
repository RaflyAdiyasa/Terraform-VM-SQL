gcp_svc_key             = "~/.config/gcloud/project-tcc-teori-2b45af6b47a5.json"
project_id              = "project-tcc-teori"
region                  = "us-central1"
zone                    = "us-central1-a"
instance_name           = "vm-instance-sql-tf-fwz"
machine_type            = "e2-medium"
disk_size               = 10
disk_type               = "pd-balanced"
image                   = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250508"
metadata_startup_script = "startup-script.sh"
tags = ["http-server", "https-server", "allow-mysql"]