#!/bin/bash

printf "\nUbuntu Post-Installation script.\nBuilt by RedFoxFinn.\nRelies on Bash, APT & Dialog.\n"

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    printf "\nsudo is required to run this script\n"
    exit 1
fi

printf "\nrunning updates via apt\n\n"
apt update && apt upgrade -y && apt dist-upgrade -y
printf "\nrunning autoremove & autoclean\n\n"
apt autoremove -y && apt autoclean
printf "\nadding universe\n\n"
add-apt-repository universe
printf "\nadding multiverse\n\n"
add-apt-repository multiverse

dialog=${usedialog:-true}

while [ $# -gt 0 ]; do
    if [[ $1 == *"--"* ]]; then
	param="${1/--/}"
	declare $param="$2"
    fi
  shift
done

if [[ $dialog == "true" ]]; then
    printf "\ninstalling dialog via apt\n\n"
    apt install -y dialog
    printf "\n\n"

    cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(
	        1 "Build Essentials" off
	        2 "Node, npm, yarn" off
	        3 "Git" off
	        4 "Ubuntu Restricted Extras" off
	        5 "Google Chrome" off
		6 "VS Code" off
		7 "Generate SSH Keys" off
		8 "Darktable" off
		9 "Texmaker" off
		10 "TeamViewer" off
		11 "Steam" off
		12 "Terminator" off
		13 "Gnome Tweak Tool" off
		14 "JDK" off
		15 "Vim" off
		16 "Regolith DE" off
	)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)	# Install Build Essentials
				printf "\nInstalling Build Essentials\n\n"
				apt install -y build-essential
				;;
				
			2)	# Install Nodejs, npm & yarn
				printf "\nInstalling Nodejs\n\n"
				curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
				apt install -y nodejs
				printf "\nInstalling npm\n\n"
                                apt install -y npm
				printf "\nInstalling yarn\n\n"
				npm install --global yarn
				;;

			3)	# Install git
				printf "\nInstalling Git, please congiure git later...\n\n"
				apt install git -y
				;;
			
			4)	# Ubuntu Restricted Extras
				printf "\nInstalling Ubuntu Restricted Extras\n\n"
				apt install ubuntu-restricted-extras -y
				;;
			
			5)	# Chrome
				printf "\nInstalling Google Chrome\n\n"
				wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
				apt install -y ./google-chrome-stable_current_amd64.deb
				;;
			
			6)	# VS Code
				printf "\nInstalling Visual Studio Code\n\n"
				wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
				apt install -y ./code_*.deb
				;;
			
			7)	# Generate SSH keys
				printf "\nGenerating SSH keys\n\n"
				ssh-keygen -t rsa -b 4096
				;;
			
			8)	# Install Darktable
				printf "\nInstalling Darktable\n\n"
				apt install -y darktable
				;;

			9)	# Install Texmaker
				printf "\nInstalling Texmaker\n\n"
				apt install -y texmaker texmaker-data texlive-base texlive-binaries texlive-extra-utils texlive-font-utils texlive-fonts-extra texlive-fonts-recommended texlive-lang-english texlive-lang-european texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-pictures texlive-plain-generic
				;;

			10)	# Install TeamViewer
				printf "\nInstalling TeamViewer\n\n"
				wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
				apt install -y ./teamviewer_amd64.deb
				;;

			11)	# Install Steam
				printf "\nInstalling Steam\n\n"
				apt install -y steam
				;;

			12)	# Install Guake
				printf "\nInstalling Terminator terminal\n\n"
				apt install -y terminator
				;;

			13)	# Install Gnome Tweak Tool
				printf "\nInstalling Gnome Tweak Tool\n\n"
				apt install -y gnome-tweak-tool
				;;

			14)	# Install JDK
				printf "\nInstalling default-jdk\n\n"
				apt install -y default-jdk
				;;

			15)	# Install Vim
				printf "\nInstalling Vim\n\n"
				apt install -y vim
				;;
				
			16)	# Install Regolith DE
				printf "\nInstalling Regolith\n\n"
				add-apt-repository ppa:regolith-linux/release
				apt update
				apt install -y regolith-desktop i3xrocks i3xrocks-cpu-usage i3xrocks-time i3xrocks-battery i3xrocks-memory

	    esac
	done
fi

printf "\nRemoving unnecessary packages and installation files\n\ŋ"
rm -rf *.deb && apt autoremove -y && apt autoclean

printf "\nEnd of script reached\n\n"
