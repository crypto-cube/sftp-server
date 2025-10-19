FROM alpine:latest

# Install OpenSSH server
RUN apk add --no-cache openssh-server

# Accept password as build argument
ARG BACKUP_PASSWORD=yourpassword

# Create backup user (no password, no shell, no home directory yet)
RUN adduser -D -H -s /sbin/nologin backup && \
    echo "backup:${BACKUP_PASSWORD}" | chpasswd

# Create chroot directory structure
# ALL parent directories in the chroot path must be owned by root
RUN mkdir -p /home/backup/chroot/uploads && \
    chown root:root /home && \
    chown root:root /home/backup && \
    chown root:root /home/backup/chroot && \
    chmod 755 /home /home/backup /home/backup/chroot && \
    chown root:root /home/backup/chroot/uploads && \
    chmod 333 /home/backup/chroot/uploads

# Generate SSH host keys
RUN ssh-keygen -A

# Copy custom sshd_config
COPY sshd_config /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 2222

# Run sshd in foreground
CMD ["/usr/sbin/sshd", "-D", "-e"]
