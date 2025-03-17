# Email Sending Script using Bash & msmtp

This script allows you to send a personalized email to a recruiter by taking user input for the recruiter's email, company name, and recruiter's name. It uses **msmtp** as the SMTP client.

## Prerequisites

Ensure you have the following installed on your system:
- `msmtp`
- `mailutils` (for some Linux distributions)

### Install Dependencies:
#### **For macOS (Using Homebrew)**
```bash
brew install msmtp
```

#### **For Ubuntu/Debian (Linux)**
```bash
sudo apt update && sudo apt install msmtp mailutils -y
```

## Configure `msmtp`

1. Open the `msmtp` config file:
   ```bash
   nano ~/.msmtprc
   ```
2. Add the following configuration:
   ```plaintext
   defaults
   auth           on
   tls            on
   tls_trust_file /etc/ssl/certs/ca-certificates.crt
   logfile        ~/.msmtp.log

   account gmail
   host smtp.gmail.com
   port 587
   from atulrajput.work@gmail.com
   user atulrajput.work@gmail.com
   password "YOUR_APP_PASSWORD"
   auth on
   tls on

   account default : gmail
   ```
3. Save the file and set permissions:
   ```bash
   chmod 600 ~/.msmtprc
   ```

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/email-script.git
   cd email-script
   ```

2. Make the script executable:
   ```bash
   chmod +x send_email.sh
   ```

3. Run the script:
   ```bash
   ./send_email.sh
   ```

4. Enter the required details when prompted:
   - Recruiter's email
   - Company name
   - Recruiter's name

5. The script will send an email to the recruiter with a customized message.

## Notes
- Ensure **msmtp** is properly configured before running the script.
- For Gmail, use an **App Password** instead of your actual password to enhance security.

## License
This project is open-source and available under the **MIT License**.

---

Feel free to contribute and improve this script! 🚀

