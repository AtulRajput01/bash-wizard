# SSH Machine Switcher

Easily switch between multiple SSH machines using a simple interactive script.

## 📌 Step 1: Create the SSH Config File (`machines.txt`)

Open a terminal and create a new file:

```bash
nano machines.txt
```

Copy-paste this inside the file:

```txt
aayan-dev-server,ubuntu,/home/amazing_atul/Downloads/devserver.pem,ec2-54-236-98-193.compute-1.amazonaws.com
k8s-aayan-machine,ubuntu,/home/amazing_atul/Downloads/devserver.pem,ec2-174-129-237-32.compute-1.amazonaws.com
razespace-machine,ubuntu,/home/amazing_atul/Downloads/razespace.pem,ec2-54-172-118-239.compute-1.amazonaws.com
```

Save and exit (`CTRL + X`, then `Y`, then `ENTER`).

---

## 📌 Step 2: Create the SSH Switch Script (`ssh-switch.sh`)

Now, create the script:

```bash
nano ssh-switch.sh
```

Copy-paste this inside:

```bash
#!/bin/bash

CONFIG_FILE="machines.txt"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Config file not found! Please create machines.txt."
    exit 1
fi

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
```

Save and exit (`CTRL + X`, then `Y`, then `ENTER`).

---

## 📌 Step 3: Make the Script Executable

Give execution permission to the script:

```bash
chmod +x ssh-switch.sh
```

---

## 📌 Step 4: Move the Script to a Global Location

To use `ssh-switch` from anywhere, move it to `/usr/local/bin/`:

```bash
sudo mv ssh-switch.sh /usr/local/bin/ssh-switch
```

Now, you can run the script from any location by simply typing:

```bash
ssh-switch
```

---

## 📌 Step 5: Running the Script

Execute the script using:

```bash
ssh-switch
```

You will see:

```
Available Machines:
1 aayan-dev-server
2 k8s-aayan-machine
3 razespace-machine
Select a machine (number): _
```

Enter the number corresponding to the machine you want to connect to. 🎉

---

## 📌 Adding a New Machine

To add a new machine, simply edit `machines.txt`:

```bash
nano machines.txt
```

Add a new entry in this format:

```txt
<machine_name>,<user>,<pem_file_path>,<EC2_public_IP_or_DNS>
```

Example:

```txt
allan-server,ubuntu,/home/amazing_atul/Downloads/allan.pem,ec2-18-221-196-222.us-east-2.compute.amazonaws.com
```

Save and exit, and the machine will be available the next time you run `ssh-switch`! 🚀

