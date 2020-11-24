sudo apt update
sudo apt upgrade
sudo apt -y install task-japanese locales-all
sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale
sudo apt install -y fonts-noto-cjk
sudo apt install -y fcitx-mozc
echo Environment="QT_IM_MODULE=fcitx"| sudo tee -a  /etc/systemd/user/cros-garcon.service.d/cros-garcon-override.conf
echo Environment="GTK_IM_MODULE=fcitx" | sudo tee -a  /etc/systemd/user/cros-garcon.service.d/cros-garcon-override.conf
echo Environment="XMODIFIERS=@im=fcitx" | sudo tee -a  /etc/systemd/user/cros-garcon.service.d/cros-garcon-override.conf
sudo echo /usr/bin/fcitx-autostart >> ~/.sommelierrc

export XMODIFIERS=@im=fcitx
fcitx-autostart
fcitx-configtool

# JetBrains Toolbox
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
DIR=$(find . -maxdepth 1 -type d -name jetbrains-toolbox-\* -print | head -n1)
cd $DIR
./jetbrains-toolbox
cd ..
rm -r $DIR
rm jetbrains-toolbox.tar.gz

# install Docker
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
sudo curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable"
sudo apt-get install docker-ce
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# https://doc.rust-lang.org/cargo/getting-started/installation.html
curl -fsSL https://starship.rs/install.sh | sudo bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
