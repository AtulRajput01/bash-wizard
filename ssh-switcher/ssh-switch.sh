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

# Check dependencies
if ! command -v neofetch &> /dev/null; then
    echo -e "${RED}⚠ Neofetch is not installed! Run: sudo apt install neofetch${RESET}"
    exit 1
fi

# Clear and Show Hacker Interface
clear
neofetch --ascii_distro kali
echo -e "${RED}${BOLD}                                                               █████╗ ████████╗██╗   ██╗██╗        ${RESET}"
echo -e "${RED}${BOLD}                                                              ██╔══██╗╚══██╔══╝██║   ██║██║        ${RESET}"
echo -e "${RED}${BOLD}                                                              ███████║   ██║   ██║   ██║██║        ${RESET}"
echo -e "${RED}${BOLD}                                                              ██╔══██║   ██║   ██║   ██║██║        ${RESET}"
echo -e "${RED}${BOLD}                                                              ██║  ██║   ██║   ╚██████╔╝███████╗   ${RESET}"
echo -e "${RED}${BOLD}                                                              ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝   ${RESET}"
echo -e "${GREEN}${BOLD}                                                                                      ...                            ${RESET}\n"

# Welcome Animation
echo -ne "${BLUE}${BOLD}"
for i in {1..2}; do
    for j in W e l c o m e   b a c k   A t u l; do
        echo -n "$j"
        sleep 0.01
    done
    echo -ne "\r               \r"
    sleep 0.1
done

# Blinking Welcome Message
echo -e "${BLUE}${BOLD}${BLINK}"
echo "                                                                ╔════════════════════════╗"
echo "                                                                ║   WELCOME BACK ATUL!   ║"
echo "                                                                ╚════════════════════════╝"
sleep 1
echo -ne "${RESET}"

# Boom Animation
echo -e "\n${GREEN}${BOLD}"
echo "                                                               \    /_\    / " 
echo "                                                                \/     \/  "
echo "                                                                 ) Activated(   " 
echo "                                                                /  \/  \   "
echo "                                                               /   ||   \  "
echo "                                                                   ||       "
echo "                                                                   ||       "
echo "                                                                   ||       "
echo -e "${RESET}"

# Matrix effect
for i in {1..15}; do
    echo -ne "${GREEN}$(tr -dc '01' < /dev/urandom | head -c 20)${RESET}"
    echo -n " "
    sleep 0.01
done
echo -e "\n"

# Popup notification
if command -v notify-send &> /dev/null; then
    notify-send "System Alert" "Access Granted: Welcome Back Atul!"
else
    echo -e "${YELLOW}Desktop notifications not available${RESET}"
fi

# Scanning animation
echo -e "\n${CYAN}${BOLD}🔍 Scanning network interfaces...${RESET}"
for i in {1..5}; do
    echo -n "${GREEN}■${RESET} "
    sleep 0.1
done
echo -e "\n"

# Rest of the original script remains the same...
# [Keep the original machine selection and connection code below]
# ... (The rest of your original script continues here) ...

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

# Connection animation
echo -e "\n${YELLOW}🔗 Establishing connection to ${GREEN}$name${RESET}..."
sleep 1

typing_effect() {
    text="$1"
    delay=0.01
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${CYAN}${text:$i:1}${RESET}"
        sleep $delay
    done
    echo ""
}

typing_effect "🚀 Initiating encrypted SSH tunnel..."
sleep 1
typing_effect "🔑 Verifying private key..."
sleep 1
typing_effect "📡 Sending authentication packets..."
sleep 1
typing_effect "✅ Secure connection established!"
sleep 1

# Sound alert
echo -e "\a"

# Matrix loading effect
for i in {1..10}; do
    echo -ne "${GREEN}$(openssl rand -hex 2)${RESET} "
    sleep 0.01
done
echo ""

# Execute SSH
ssh -i "$key" "$user@$host"
