FROM debian:latest

# Set exposed port for container
ENV WEB_HTTP_PORT 80
ENV WEB_HTTPS_PORT 443

# Set time zone
ENV TZ Europe/Brussels

# Set miscaleneous parameters
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# Working directory
WORKDIR /

# OS preparation
RUN echo "deb http://ftp.be.debian.org/debian/ buster main contrib non-free" >> /etc/apt/sources.list && \
    apt update && \
    apt install -y apt-utils && \
    apt install -y systemd git gpg wget curl && \
    rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp* \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
    

# Copy Centreon installation script
COPY centreon_central.sh /
    
# Copy entrypoint file
COPY entrypoint.sh /
    
# Ports exposure
EXPOSE ${WEB_HTTP_PORT}
EXPOSE ${WEB_HTTPS_PORT}

# Ensure data are saved externally
VOLUME [ "/sys/fs/cgroup" ]

# Using script to ensure no arguments car be sent to the container when starting.
ENTRYPOINT [ "/entrypoint.sh" ]

# Default is start option
CMD [ "start" ]
