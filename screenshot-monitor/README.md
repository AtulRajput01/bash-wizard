# Screenshot Automation Script

## 📌 Overview
This PowerShell script automatically takes screenshots at regular intervals and saves them to a specified folder. You can set up Task Scheduler to run this script at startup.

---

## 🔹 Step 1: Install Required Components
💻 Run this command in **PowerShell as Administrator** to allow scripts to run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
Install-Module -Name PSTools -Force -Scope CurrentUser
```

---

## 🔹 Step 2: Save the Script
Save the following PowerShell script as `screenshot.ps1` in your Documents folder:

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a folder to save screenshots
$ScreenshotPath = "C:\Screenshots"
If (!(Test-Path -Path $ScreenshotPath)) {
    New-Item -ItemType Directory -Path $ScreenshotPath
}

# Infinite loop to take screenshots at intervals
while ($true) {
    $screen = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
    $bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphic.CopyFromScreen(0, 0, 0, 0, $bitmap.Size)
    
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $path = "$ScreenshotPath\screenshot_$timestamp.png"
    $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)

    Write-Host "Screenshot saved: $path"

    Start-Sleep -Seconds 10  # Change to any interval (600s = 10 mins)
}
```

---

## 🔹 Step 3: Create a Scheduled Task
📌 This ensures the script runs automatically on every startup.

### 1️⃣ Open Task Scheduler:
Press `Win + R`, type `taskschd.msc`, and press **Enter**.

### 2️⃣ Create a New Task:
Click **Create Task** (on the right panel).

### 3️⃣ General Tab:
- **Name:** `Screenshot Monitor`
- **Select:** `Run whether user is logged on or not`
- **Check:** `Run with highest privileges`

### 4️⃣ Triggers Tab:
- Click **New**
- Set **Begin the task** to `At startup`
- Click **OK**

### 5️⃣ Actions Tab:
- Click **New**
- Choose **Start a Program**
- In `Program/script`, enter:
  ```plaintext
  powershell.exe
  ```
- In `Add arguments`, enter:
  ```plaintext
  -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\Administrator\Documents\screenshot.ps1"
  ```
- Click **OK**

### 6️⃣ Conditions & Settings Tab (Optional but Recommended)
- **Uncheck** `Stop if computer switches to battery` (if on a laptop)
- **Check** `Restart the task if it fails`
- Click **OK**

### 7️⃣ Save & Run:
- Click **OK**, enter your password if asked
- In **Task Scheduler**, right-click `Screenshot Monitor` → Click **Run**

---

## 🔹 Step 4: Run the Script Manually (Optional)
If you want to run the script manually, use this command:

```powershell
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\Administrator\Documents\screenshot.ps1"
```

This will run the script in the background without opening a PowerShell window.

---

## 📢 Notes
- Ensure PowerShell execution policies allow running scripts.
- Screenshots are saved in `C:\Screenshots` by default.
- Modify `Start-Sleep -Seconds 10` in the script to change the interval.

---
