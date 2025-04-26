FROM oraclelinux:9

# Install NGINX and admin tools
RUN dnf -y update && \
    dnf -y install epel-release && \
    dnf -y install nginx vim curl wget htop net-tools tcpdump \
                   bind-utils iproute iputils procps-ng && \
    dnf clean all

# Configure NGINX
COPY nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/
RUN mkdir -p /var/log/nginx && \
    chmod -R 755 /usr/share/nginx/html

# Copy system administration scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Set environment variables
ENV NGINX_LOG_LEVEL=info

# Expose ports
EXPOSE 80 443

# Start NGINX
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
