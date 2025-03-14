#!/bin/bash

CONFIG_FILE="machines.txt"

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
CYAN="\e[36m"
MAGENTA="\e[35m"
RESET="\e[0m"
BOLD="\e[1m"
BLINK="\e[5m"

# Check if neofetch is installed
if ! command -v neofetch &> /dev/null; then
    echo -e "${RED}⚠ Neofetch is not installed! Run: sudo apt install neofetch${RESET}"
    exit 1
fi

# Clear Screen and Show HACKER ASCII Art
clear
neofetch --ascii_distro kali
echo -e "${MAGENTA}${BOLD} █████╗ ████████╗██╗   ██╗██╗        ${RESET}"
echo -e "${MAGENTA}${BOLD}██╔══██╗╚══██╔══╝██║   ██║██║        ${RESET}"
echo -e "${MAGENTA}${BOLD}███████║   ██║   ██║   ██║██║        ${RESET}"
echo -e "${MAGENTA}${BOLD}██╔══██║   ██║   ██║   ██║██║        ${RESET}"
echo -e "${MAGENTA}${BOLD}██║  ██║   ██║   ╚██████╔╝███████╗   ${RESET}"
echo -e "${MAGENTA}${BOLD}╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝   ${RESET}"
echo -e "${MAGENTA}${BOLD}      ...                            ${RESET}\n"

# Blinking HACK MODE ALERT
for i in {1..5}; do
    echo -ne "${RED}${BOLD}${BLINK}⚠ HACK MODE ACTIVATED ⚠${RESET}\r"
    sleep 0.3
    echo -ne "                             \r"
    sleep 0.3
done
echo -e "${CYAN}${BOLD}🔍 Scanning for available SSH machines...${RESET}\n"

# List Machines
echo -e "${GREEN}Available Machines:${RESET}"
awk -F',' '{printf "  %s) %s\n", NR, $1}' "$CONFIG_FILE"

# User Input
echo -ne "\n${BLUE}Select a machine by number or name: ${RESET}"
read choice

# Validate input
if [[ "$choice" =~ ^[0-9]+$ ]]; then
    selected=$(sed -n "${choice}p" "$CONFIG_FILE")
elif grep -q "^$choice," "$CONFIG_FILE"; then
    selected=$(grep "^$choice," "$CONFIG_FILE")
else
    echo -e "${RED}❌ Invalid input. Please enter a valid number or machine name.${RESET}"
    exit 1
fi

if [ -z "$selected" ]; then
    echo -e "${RED}❌ Invalid choice!${RESET}"
    exit 1
fi

# Extract details
name=$(echo "$selected" | cut -d',' -f1)
user=$(echo "$selected" | cut -d',' -f2)
key=$(echo "$selected" | cut -d',' -f3)
host=$(echo "$selected" | cut -d',' -f4)

# Hacker-style connection effect
echo -e "\n${YELLOW}🔗 Establishing connection to ${GREEN}$name${RESET}..."
sleep 1

# Matrix-style typing effect
typing_effect() {
    text="$1"
    delay=0.04
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${CYAN}${text:$i:1}${RESET}"
        sleep $delay
    done
    echo ""
}

# Fake hacking animations 😆
typing_effect "🚀 Initiating encrypted SSH tunnel..."
sleep 1
typing_effect "🔑 Verifying private key..."
sleep 1
typing_effect "📡 Sending authentication packets..."
sleep 1
typing_effect "✅ Secure connection established!"
sleep 1

# Sound alert (if terminal supports)
echo -e "\a"

# Matrix loading effect
for i in {1..10}; do
    echo -ne "${GREEN}$(openssl rand -hex 2)${RESET} "
    sleep 0.05
done
echo ""

# Execute SSH
ssh -i "$key" "$user@$host"
