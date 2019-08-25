SHELL=/bin/bash
GPG=$(SHELL gpg --list-secret-keys --keyid-format LONG | grep AC2291CF29056C5C)
PLATFORM := $(shell [[ -z $(WSL_DISTRO_NAME) ]] && echo "nonwsl" || echo "wsl")

all:$(PLATFORM)
standard: core docker k8s fish powershell azcli keybase git sqlpackage
nonwsl: standard mate chrome vscode clean
wsl: standard wslconfig clean

core:
	echo "Setting up platform [ $(PLATFORM) ]"
	rm -rf /tmp/make
	mkdir -p /tmp/make

	echo "Europe/London" | sudo tee /etc/timezone
	sudo dpkg-reconfigure --frontend noninteractive tzdata

	sudo apt update
	sudo apt upgrade -y
	sudo apt dist-upgrade -f

	sudo apt install -y build-essential
	sudo apt install -y apt-transport-https
	sudo apt install -y ubuntu-restricted-extras
	sudo apt install -y unzip
	sudo apt install -y containerd

git:
	sudo apt install -y git

	sudo add-apt-repository -y ppa:cpick/hub
	sudo apt update
	sudo apt install -y hub

	cat ../shared/gitconfig | keybase pgp decrypt > $(HOME)/.gitconfig
	git config credential.helper store

mate:
	sudo apt install -y ubuntu-mate-desktop;\
	sudo apt install mate-desktop-environment-extras
	sudo apt install gnome-icon-theme
	dconf dump /org/mate/terminal/profiles/default/ < mate-terminal-default-profile.dconf
	sudo ufw enable
	sudo apt install -y sudo xrdp
	sudo ufw allow 3389/tcp
	sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh

docker:
	sudo apt install -y docker.io
	sudo usermod -aG docker $(USER)

k8s:
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

	git clone https://github.com/ahmetb/kubectl-aliases.git /tmp/make/kubectl-aliases
	mv /tmp/make/kubectl-aliases/.kubectl_aliases $(HOME)/.kubectl_aliases

	wget "https://git.io/get_helm.sh" -O /tmp/make/get_helm.sh
	chmod 700 /tmp/make/get_helm.sh
	/tmp/make/get_helm.sh
	helm init --client-only

fish:
	sudo apt install fish
	sudo sed --in-place -e '/auth.*required.*pam_shells.so/s/required/sufficient/g' /etc/pam.d/chsh
	chsh -s /usr/bin/fish
	sudo sed --in-place -e '/auth.*sufficient.*pam_shells.so/s/sufficient/required/g' /etc/pam.d/chsh

	rsync -zavhr --progress config/fish $(HOME)/.config

	curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
	fish -c fisher add oh-my-fish/theme-robbyrussell

chrome:
	sudo apt install xdg-utils
	wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O /tmp/make/google-chrome-stable_current_amd64.deb
	sudo apt install /tmp/make/google-chrome-stable_current_amd64.deb

vscode:
	wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O /tmp/make/vscode.deb
	sudo apt install -y /tmp/make/vscode.deb
	cat ../shared/vscode/plugins.json | jq -r  ".[]" \
	| while read -r name; \
	do \
		echo "code --install-extension $${name}";\
		code --install-extension $${name};\
	done;\

powershell:
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/make/packages-microsoft-prod.deb
	sudo dpkg -i /tmp/make/packages-microsoft-prod.deb
	sudo apt update
	sudo add-apt-repository universe
	sudo apt install -y powershell

	cat ../shared/powershell/modules.json | jq -r  ".[] | .name, .prerelease" \
		| while read -r name prerelease; \
		do \
			[[ $${prerelease} = true ]] && p="\$$True" || p="\$$False";\
			echo "Install-Module -Name $${name} -Scope CurrentUser -AllowPreRelease:$${p} -Verbose";\
			pwsh -C Install-Module -Name $${name} -Scope CurrentUser -AllowPreRelease:$${p} -Verbose;\
		done;\

	rsync -zavh --progress config/powershell $(HOME)/.config

azcli:
	wget "https://aka.ms/InstallAzureCLIDeb" -O /tmp/make/azcli.sh
	chmod 700 /tmp/make/azcli.sh
	sudo /tmp/make/azcli.sh
	rsync -zavh ../shared/az-cli/config $(HOME)/.azure/config

keybase:
	wget https://prerelease.keybase.io/keybase_amd64.deb -O /tmp/make/keybase_amd64.deb
	sudo apt install /tmp/make/keybase_amd64.deb
	keybase login
	keybase pgp export | gpg --import
	keybase pgp export --secret --unencrypted | gpg --import

wslconfig:
	sudo rsync -zavh --progress ./etc/wsl.conf /etc/wsl.conf

sqlpackage:
	wget "https://go.microsoft.com/fwlink/?linkid=2087431" -O /tmp/make/sqlpackage.zip
	sudo mkdir -p /opt/microsoft/sqlpackage
	sudo unzip -o /tmp/make/sqlpackage.zip -d /opt/microsoft/sqlpackage
	sudo chmod a+x /opt/microsoft/sqlpackage/sqlpackage
	sudo ln -s /opt/microsoft/sqlpackage/sqlpackage /usr/bin/sqlpackage -f

clean:
	rm -rf /tmp/make
	sudo apt autoremove -y
