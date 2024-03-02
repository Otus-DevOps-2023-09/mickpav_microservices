terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~>0.35"
    }
  }
  required_version = ">= 0.12"
}
provider "yandex" {
  token     = var.token_id
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
resource "yandex_compute_instance" "docker" {
  count = var.vm_count
  name  = "docker-host-${count.index}"
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }
  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
}
