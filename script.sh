#!/bin/bash

sudo apt update

sudo apt install openjdk-21-jdk screen -y

sudo apt install wget -y

mkdir minecraft /home/vagrant

DIR="/home/vagrant/minecraft"

PROJECT="paper"
VERSION="1.21.4"
BUILD="222"
DOWNLOAD="$PROJECT-$VERSION-$BUILD.jar"

cd "$DIR"

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
# bash "start.sh"
