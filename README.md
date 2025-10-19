# SFTP Backup Server

A hardened SFTP server setup using Docker and Alpine Linux. This project is designed for secure, upload-only backups with strict access controls.

## Features
- **Lightweight**: Based on Alpine Linux with OpenSSH
- **Upload-only access**: Backup user can only upload files, not list, download, or delete
- **No SSH access**: Shell access is completely disabled, only SFTP is allowed
- **Chroot jail**: User is restricted to their designated directory
- **Password-based SFTP access**: Simple authentication with user `backup`
- **Persistent storage**: Uploaded files stored in local `./uploads` directory

## Prerequisites
- Docker
- Docker Compose

## Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/sftp-backup.git
cd sftp-backup
```

2. Initialize directories and permissions:
```bash
./init.sh
```

3. Build and start the SFTP server:
```bash
docker compose up -d --build
```

## Usage

Connect to the SFTP server using an SFTP client or command line:
```bash
sftp -P 2222 backup@your-server-ip
```
  - **Username**: `backup`
  - **Password**: `changeme` (change in `.env` file before building)

Upload files to the `/uploads/` directory:
```bash
sftp> cd /uploads
sftp> put myfile.txt
```

**Note**: The backup user can ONLY upload files. Attempting to list, download, or delete files will be denied.

## Security Configuration

This setup implements multiple layers of security to ensure upload-only access:

1. **SSH Configuration** (`sshd_config`):
   - Forces SFTP-only access (no shell)
   - Disables all SSH tunneling and forwarding
   - Implements chroot jail for the backup user

2. **Directory Permissions**:
   - Chroot directory (`/home/backup/chroot`) is owned by root (required for chroot)
   - Upload directory is owned by root with `333` permissions (write-execute only, no read)
   - User cannot list, download, or delete files after upload

3. **User Security**:
   - User has `/sbin/nologin` shell (no interactive login)
   - User is chrooted and cannot access other parts of the system

## Data Storage

- Uploaded files location: `./uploads`
- Files are persisted on the host system

## Changing the Password

Edit the `.env` file and change the password:
```bash
BACKUP_PASSWORD=yournewsecurepassword
```

Then rebuild:
```bash
docker compose up -d --build
```

**Important**: The `.env` file is excluded from git to prevent accidentally committing passwords.

## Stopping the Server

```bash
docker compose down
```

## Cleanup

To remove all data and the container:

```bash
docker compose down
rm -rf ./uploads
```
