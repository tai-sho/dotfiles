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

# https://doc.rust-lang.org/cargo/getting-started/installation.html
#curl https://sh.rustup.rs -sSf | sh
#source $HOME/.cargo/env
#cargo install exa

#sudo apt install fd-find

