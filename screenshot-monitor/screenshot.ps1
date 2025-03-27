Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a folder to save screenshots
$ScreenshotPath = "C:\Screenshots"
If (!(Test-Path -Path $ScreenshotPath)) {
    New-Item -ItemType Directory -Path $ScreenshotPath
}

# Infinite loop to take screenshots at intervals
while ($true) {
    Start-Sleep -Milliseconds 500  # Small delay before capturing

    # Get screen size
    $screen = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
    $bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)

    # Capture the screenshot
    $graphic.CopyFromScreen(0, 0, 0, 0, $bitmap.Size)

    # Generate timestamp in correct format
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $path = "$ScreenshotPath\screenshot_$timestamp.png"

    # Save only if bitmap is properly initialized
    if ($bitmap -ne $null -and $graphic -ne $null) {
        $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
        Write-Host "Screenshot saved: $path"
    } else {
        Write-Host "Failed to capture screenshot!"
    }

    # Release resources
    $graphic.Dispose()
    $bitmap.Dispose()

    Start-Sleep -Seconds 10  # Adjust interval (10s = 10 seconds)
}
