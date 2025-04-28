provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.gcp_svc_key)
}

resource "google_compute_instance" "vm_sql-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = [var.tags.1, var.tags.2, var.tags.3]

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  boot_disk {

    auto_delete = true
    device_name = "disk-tf"

    initialize_params {
      image = var.image
      size  = var.disk_size
      type  = var.disk_type
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



  metadata_startup_script = file(var.metadata_startup_script)
}


output "ip-address" {
  value       = google_compute_instance.vm_sql-tf.network_interface[0].access_config[0].nat_ip
  description = "IP Address of the VM instance"

}