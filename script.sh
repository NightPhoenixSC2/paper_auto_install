#!/bin/bash

sudo apt update

sudo apt install openjdk-21-jdk screen -y

sudo apt install wget -y

sudo mkdir minecraft /home/vagrant

DIR="/home/vagrant/minecraft"

cd "$DIR"

wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/222/downloads/paper-1.21.4-222.jar -O paper.jar
echo "eula=true" > eula.txt

echo '#!/bin/bash' > start.sh

echo 'java -Xms1G -Xmx2G -jar paper.jar nogui' >> start.sh

chmod +x start.sh

bash "start.sh"
