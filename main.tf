provider "google" {
  project = "a-07-451003"  
  region  = "us-central1"
  credentials = file(var.gcp_svc_key)
}

resource "google_compute_instance" "vm_sql-tf" {
  name         = "vm-instance-sql-tf-2"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["http-server", "https-server", "allow-mysql"]

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  boot_disk {

    auto_delete = true
    device_name = "disk-tf"
    
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250415"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

    labels = {
    goog-ec-src = "vm_add-tf"
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "PREMIUM"
    }
    
  }

 

  metadata_startup_script = file("startup-script.sh")
}


output "ip-address" {
  value = google_compute_instance.vm_sql-tf.network_interface[0].access_config[0].nat_ip
  description = "IP Address of the VM instance"
  
}