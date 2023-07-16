# syntax=docker/dockerfile:1

FROM ubuntu:22.04

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Install Cockpit
RUN apt-get update && apt-get install -y cockpit

# Expose port 9090 for Cockpit
EXPOSE 9090

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx service
CMD ["nginx", "-g", "daemon off;"]
