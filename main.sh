#!/bin/bash

# ----- Shellcheck region -----
# shellcheck disable=SC2034
# shellcheck disable=SC1091
# ----- ***************** -----

set -e

# Color for output
Black='\033[1;90m'  # Black
Red='\033[1;91m'    # Red
Green='\033[1;92m'  # Green
Yellow='\033[1;93m' # Yellow
Blue='\033[1;94m'   # Blue
Purple='\033[1;95m' # Purple
Cyan='\033[1;96m'   # Cyan
White='\033[1;97m'  # White
COF='\033[0m'       # Color off

# Detect the distro
DISTRO_PATH="/etc/os-release"
OS=""
VESION=""
if [ -f "$DISTRO_PATH" ]; then
    # shellcheck source=/etc/os-release

    source "$DISTRO_PATH"
    OS="$NAME"
    VERSION="$VERSION_ID"
else
    echo -e "${Red}Fail to retrieve OS information ${COF}"
    exit
fi

echo -e "The current OS is ${Green}$OS${COF}"
echo -e "The current verion is ${Green}$VERSION${COF}"

# Force to enter the password. There is risk but okay tho
export sudoPw=""
read -s -e -r -p "$(echo -e "${Yellow}Enter your password ${COF}: ")" sudoPw

ask_choice() {
    local question="$1"
    local choice
    read -e -r -p "$(echo -e "${Green}Do you want to install $question? ${COF}: ")" choice
    echo "${choice,,}" # Output lowercase version
}

install_gcc=$(ask_choice "GCC and G++ library")
install_nodejs=$(ask_choice "NodeJS and other stuff related to it")
install_python=$(ask_choice "Pyyyyyyy")
install_rust=$(ask_choice "A crab for sure")
install_zsh=$(ask_choice "ZSH shell along with pokemon theme")

CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if [[ "$install_gcc" == 'y' ]]; then
    source "$CURRENT_DIR/script/install_gcc.sh"

    if setup_gcc; then
        echo -e "✅ ${Green}Successfully instaling gcc${COF}"
    else
        echo -e "❌ ${Red}Failed to install gcc${COF}"
    fi
fi
