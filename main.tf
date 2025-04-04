resource "google_compute_firewall" "allow_minecraft" {
  name    = "allow-minecraft"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["25565"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["minecraft-server"]
}

resource "google_compute_instance" "terraform" {
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = "europe-west9-b"
  
  tags = ["minecraft-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install openjdk-21-jdk screen wget -y
    mkdir /home/ubuntu/minecraft
    cd /home/ubuntu/minecraft
    PROJECT="paper"
    VERSION="1.21.4"
    BUILD="222"
    DOWNLOAD="$PROJECT-$VERSION-$BUILD.jar"
    wget https://api.papermc.io/v2/projects/$PROJECT/versions/$VERSION/builds/$BUILD/downloads/$DOWNLOAD -O paper.jar
    echo "eula=false" > eula.txt
    java -jar paper.jar 
    sed -i 's/online-mode=.*/online-mode=false/' server.properties
    sed -i 's/difficulty=.*/difficulty=hard/' server.properties
    echo '#!/bin/bash' > start.sh
    echo 'java -Xms1G -Xmx2G -jar paper.jar nogui' >> start.sh
    echo "eula=true" > eula.txt
    chmod +x start.sh
    bash "start.sh"
  EOT
}
