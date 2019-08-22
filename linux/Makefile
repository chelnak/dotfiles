SHELL = /bin/bash

all: core k8s helm fish powershell azcli keybase hub wsl clean

core:
	sudo apt update
	sudo apt upgrade -y
	sudo apt dist-upgrade -f

	sudo usermod -aG docker $(USER)
	
	sudo apt install -y unzip

k8s:
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

helm:
	curl -LO https://git.io/get_helm.sh
	chmod 700 get_helm.sh
	./get_helm.sh
	helm init --client-only

fish:
	sudo apt install fish
	chsh -s /usr/bin/fish
	curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
	fish -c fisher add oh-my-fish/theme-robbyrussell
	rsync -zavhr --progress config/fish $(HOME)/.config

powershell:
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	sudo apt update
	sudo add-apt-repository universe
	sudo apt install -y powershell

	rsync -zavh --progress config/powershell $(HOME)/.config

azcli:
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

keybase:
	curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
	sudo apt install ./keybase_amd64.deb
	run_keybase

hub:
	sudo add-apt-repository -y ppa:cpick/hub
	sudo apt update
	sudo apt -y install hub
	git config --global hub.protocol https

wsl:
	sudo rsync -zavh --progress ./etc/wsl.conf /etc/wsl.conf

sqlpackage:	
	wget "https://go.microsoft.com/fwlink/?linkid=2087431" -O sqlpackage.zip
	sudo mkdir -p /opt/microsoft/sqlpackage
	sudo unzip sqlpackage.zip -d /opt/microsoft/sqlpackage
	sudo chmod a+x /opt/microsoft/sqlpackage/sqlpackage
	sudo ln -s /opt/microsoft/sqlpackage/sqlpackage /usr/bin/sqlpackage

clean:
	rm -f get_helm.sh
	rm -f keybase*.deb
	rm -f packages-microsoft-prod.deb
	rm -f sqlpackage.zip
