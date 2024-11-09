# SFTP Backup Server

A simple SFTP server setup using Docker and `linuxserver/openssh-server`. This project is designed for secure backups with password-based access.

## Features
- Uses `linuxserver/openssh-server` for a sandboxed SSH environment.
- Password-based SFTP access.
- User `backup` with configurable password.
- All data stored in local project directories.

## Prerequisites
- Docker
- Docker Compose

## Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/sftp-backup.git
cd sftp-backup
````

2. Initialize directories and permissions:
```bash
./init.sh
```

3. Start the SFTP server:
```bash
docker-compose up -d
```

## Usage

- Connect to the SFTP server using an SFTP client or command line:
```bash
sftp -P 2222 backup@your-server-ip
```
  - **Username**: `backup`
  - **Password**: As set in `docker-compose.yml` (`yourpassword`)

## Data Storage

- Configuration files: `./sftp/config`
- User data directory: `./sftp/data`

## Stopping the Server

```bash
docker-compose down
```

## Cleanup

To remove all data and configurations:

```bash
rm -rf ./sftp
```
