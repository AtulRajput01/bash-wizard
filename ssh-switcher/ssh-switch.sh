#!/bin/bash

CONFIG_FILE="machines.txt"

echo "Available Machines:"
awk -F',' '{print NR, $1}' "$CONFIG_FILE"

echo -n "Select a machine (number): "
read choice

if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
    echo "❌ Invalid input. Please enter a number."
    exit 1
fi

selected=$(sed -n "${choice}p" "$CONFIG_FILE")
if [ -z "$selected" ]; then
    echo "❌ Invalid choice!"
    exit 1
fi

name=$(echo "$selected" | cut -d',' -f1)
user=$(echo "$selected" | cut -d',' -f2)
key=$(echo "$selected" | cut -d',' -f3)
host=$(echo "$selected" | cut -d',' -f4)

echo "🔗 Connecting to $name..."
ssh -i "$key" "$user@$host"
