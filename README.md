# 🚀 n8n Docker Setup Guide (with Optional GitHub Backup)

This guide provides two setup methods for deploying `n8n` using Docker and Traefik:

* **Method 1**: For users who **do not need GitHub backup**
* **Method 2**: For users who **want to maintain a private GitHub backup**

---

## 🔧 Method 1: Simple Setup (Without GitHub Backup)

Clone the repository and set up your environment:

```bash
git clone https://github.com/deepak12singh/n8n-docker.git
cd n8n-docker
sudo chown -R 1000:1000 ./data
cp .env.example .env
```

Edit the `.env` file to match your configuration:

```bash
nano .env
```

If `nano` is not installed, run:

```bash
sudo apt install nano
```

---

### 📄 Sample `.env` Configuration

This configuration is the same for both Method 1 and Method 2.

```dotenv
# Domain and SSL
DOMAIN_NAME=domain.name
SUBDOMAIN=n8n
SSL_EMAIL=your-email@example.com

# Traefik dashboard security
TRAEFIK_DASHBOARD_AUTH=admin:$$apr1$$mjerhkKV$$LxgKGSv6cNFZRi.Dx/zfO1
TRAEFIK_LOG_LEVEL=INFO

# n8n security
N8N_ENCRYPTION_KEY=your-strong-key-for-credentials-protection
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=supersecurepassword

# Logging and timezone
GENERIC_TIMEZONE=Asia/Kolkata
N8N_LOG_LEVEL=debug
N8N_LOG_OUTPUT=file
N8N_DIAGNOSTICS_ENABLED=false
N8N_PERSONALIZATION_ENABLED=false
N8N_DISABLE_PRODUCTION_MAIN_MENU=true
```

---

### ▶️ Start Docker Services

Use the following commands to build and launch the container:

```bash
docker compose up -d --build
docker compose logs -f
```

---

## 🔐 Method 2: With GitHub Backup (Private Repository)

This method includes pushing your customized environment to a **private GitHub repository**.

---

### 🔹 Step 1: Clone the Public Repository

```bash
git clone https://github.com/deepak12singh/n8n-docker.git
cd n8n-docker
```

---

### 🔹 Step 2: Create a New Private Repository

1. Go to [https://github.com/new](https://github.com/new)
2. Repository name: `n8n-docker` (or any custom name)
3. Set visibility to **Private**
4. Do **not** initialize with README, .gitignore, or license

---

### 🔹 Step 3: Install GitHub CLI and Authenticate

```bash
sudo apt update
sudo apt install gh
gh auth login
```

Follow prompts:

* Account: GitHub.com
* Protocol: HTTPS
* Authenticate Git: Yes
* Login Method: Web Browser

A one-time code will be shown. Enter it at [https://github.com/login/device](https://github.com/login/device).

---

### 🔹 Step 4: Set Git Identity (Only Once Per System)

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

### 🔹 Step 5: Initialize Git and Push to Private Repository

```bash
git init
git add .
git commit -m "Initial commit"

# Remove original remote if it exists
git remote remove origin

# Add your private repository
git remote add origin https://github.com/Deepakas1ngh/n8n-docker.git

# Push to main branch
git push -u origin main
# OR if using master
git push -u origin master
```

---

### 🔹 Step 6: Configure `.env`

```bash
cp .env.example .env
nano .env
```

Edit environment variables according to your deployment needs.

---

### ▶️ Start Docker Services

```bash
docker compose up -d --build
docker compose logs -f
```

---

## 🔄 Optional: Auto Git Push Using Cron

To automate git backups, ensure your scripts are executable:

```bash
chmod +x auto_git_push.sh
chmod +x set_shared_permissions.sh
```

---

### 🛠 Install Cron (if not installed)

```bash
sudo apt install cron -y
sudo systemctl enable cron
sudo systemctl start cron
```

---

### ✏️ Add a Cron Job (Runs Every Hour)

Open the crontab editor:

```bash
crontab -e
```

Add the following line (replace the full path and user name as per your system):

```bash
0 * * * * /home/deepak/n8n-docker-traefik/auto_git_push.sh >> /home/deepak/git_push.log 2>&1
```

Verify your crontab:

```bash
crontab -l
```

---

## 🧰 Useful Git & GitHub CLI Commands

| Task                          | Command              |
| ----------------------------- | -------------------- |
| Check GitHub CLI auth         | `gh auth status`     |
| Check Git repo status         | `git status`         |
| View commit history           | `git log --oneline`  |
| Show current remote URL       | `git remote -v`      |
| Rename current branch to main | `git branch -M main` |

---

📅 Your `n8n` + `Traefik` Docker setup is now ready. You can choose either a quick standalone deployment or an advanced version with GitHub backup automation.

---

### ℹ️ Need More Help?

Let me know if you’d like to include any of the following:

* 🌐 Example Traefik dashboard access URL
* 🔐 Let's Encrypt HTTPS setup verification
* 🔒 `.env` secrets encryption (`openssl`, etc.)
