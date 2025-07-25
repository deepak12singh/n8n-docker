
# 🚀 n8n Docker Setup Guide (with Optional GitHub Backup)

This guide provides two methods for deploying `n8n` using Docker and Traefik:

- **Method 1**: For users who **do not need GitHub backup**
- **Method 2**: For users who **want to maintain a private GitHub backup**

---

## 🔧 Method 1: Simple Setup (Without GitHub Backup)

Clone the repository and set up your environment:

```bash
git clone https://github.com/deepak12singh/n8n-docker.git
cd n8n-docker
sudo chown -R 1000:1000 ./data
cp .env.example .env
````

Edit the `.env` file to match your configuration:

```bash
nano .env
```

If `nano` is not installed:

```bash
sudo apt install nano
```

---

### 📄 Sample `.env` Configuration

This configuration applies to both Method 1 and Method 2. **You must change these values to fit your setup.**

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
```

---

### ▶️ Start Docker Services

Use the following commands to build and launch the containers:

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

1. Visit [https://github.com/new](https://github.com/new)
2. Set the repository name (e.g., `n8n-docker`)
3. Choose **Private** visibility
4. Leave **README**, **.gitignore**, and **license** unchecked

---

### 🔹 Step 3: Install GitHub CLI and Authenticate

```bash
sudo apt update
sudo apt install gh
gh auth login
```

Follow the prompts:

* Account: GitHub.com
* Protocol: HTTPS
* Authenticate Git: Yes
* Login Method: Web Browser

A one-time code will be displayed. Enter it at [https://github.com/login/device](https://github.com/login/device).

---

### 🔹 Step 4: Set Git Identity (One-Time Configuration)

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

### 🔹 Step 5: Initialize Git and Push to Private Repository

```bash
rm -rf .git
git init
git branch -m main
git add .
git commit -m "Initial commit"

# Add your private repository
git remote add origin https://github.com/Deepakas1ngh/n8n-docker.git

# Push to main branch
git push -u origin main

# (Optional) If using 'master' instead of 'main':
# git push -u origin master
```

---

### 🔹 Step 6: Configure `.env`

```bash
cp .env.example .env
nano .env
```

Edit environment variables based on your deployment requirements.

---

## 🔄 Optional: Auto Git Push Using Cron

To automate Git backups, make sure your scripts are executable:

```bash
chmod +x auto_git_push.sh
chmod +x set_shared_permissions.sh
```

---

### ▶️ Start Docker Services

```bash
docker compose up -d --build
docker compose logs -f
```

---

### 🛠 Install Cron (if not already installed)

```bash
sudo apt install cron -y
sudo systemctl enable cron
sudo systemctl start cron
```

---

### ✏️ Add a Cron Job (Runs Every Hour)

First, copy the full path of `auto_git_push.sh`:

```bash
pwd
```

Then open the crontab editor:

```bash
crontab -e
```

Add the following line (update the path and username if needed):

```bash
0 * * * * /home/deepak/n8n-docker/auto_git_push.sh >> /home/deepak/n8n-docker/git_push.log 2>&1
```

Verify the cron job:

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

📅 Your `n8n` + `Traefik` Docker setup is now ready. You can choose between a quick standalone deployment or a fully automated GitHub backup strategy.

---

## 👤 Author

**Deepak Singh**

* 🌐 GitHub: [deepak12singh](https://github.com/deepak12singh)
* 🔗 LinkedIn: [linkedin.com/in/deepak12singh](https://www.linkedin.com/in/deepak12singh/)
* 📧 Email: [deepak12singh93@gmail.com](mailto:deepak12singh93@gmail.com)

---


