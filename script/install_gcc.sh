#!/bin/bash

# ----- Shellcheck region -----
# shellcheck disable=SC2034
# shellcheck disable=SC1091
# shellcheck disable=SC2154
# ----- ***************** -----

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

setup_gcc() {
    echo "$sudoPw" | sudo -S apt-get update && sudo apt-get upgrade
    echo "$sudoPw" | sudo -S apt-get install build-essential

    if command -v gcc >/dev/null; then
        gcc_version=$(gcc -dumpfullversion)
        echo -e "GCC version: ${Green}$gcc_version${COF}"
        return 0
    else
        echo -e "${Red}GCC not found${COF}"
    fi

    return 1
}
