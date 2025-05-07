FROM n8nio/n8n:latest
# Temporarily switch to root to install packages
USER root
RUN apk update && apk add zip
# Switch back to the default non-root user (usually 'node' for n8n images)
USER node
