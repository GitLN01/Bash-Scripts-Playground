# Bash-Scripts-Playground

Welcome to the **Bash-Scripts-Playground**!  
This repository contains a variety of Bash scripts developed for learning, automation, and experimentation purposes.  
Each script serves a practical use case, from cleaning up directories and backing up data to monitoring system health and simplifying DevOps workflows.

---

## Purpose:

This repository aims to:
- Practice Bash scripting and Linux command-line usage
- Automate repetitive tasks in Unix-like environments
- Serve as a personal knowledge base for shell scripting
- Provide reusable scripts for everyday sysadmin and DevOps tasks

---

## Structure:

Scripts are organized as standalone `.sh` files in the root directory. Each script includes inline comments explaining its functionality and usage.

---

## How to Run Scripts on Linux-based Systems:

Follow these steps to run any script in this repository on Debian or any Debian-based Linux distro (e.g. Ubuntu, Linux Mint):

### 1. Clone the repository

```bash
git clone https://github.com/YourUsername/Bash-Scripts-Playground.git
cd Bash-Scripts-Playground
```
### 2. Make the script executable

```bash
chmod +x your-script.sh
```
### 3. Run the script

```bash
./your-script.sh [arguments]
```

### Example

Let's run 4.sh, a script that deletes files older than a given number of minutes in a target directory:

```bash
chmod +x 4.sh
./4.sh /home/username/Downloads 30
```

This will:
- Check if /home/username/Downloads exists and is accessible
- Delete all files older than 30 minutes
- Ask for confirmation before proceeding
- Log deleted files to logs/cleanup.log
