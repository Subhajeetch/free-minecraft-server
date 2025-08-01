# Use Node.js 18 with Alpine Linux (lightweight)
FROM node:18-alpine

# Install OpenJDK 21 and curl for downloads
RUN apk add --no-cache openjdk21-jre curl

# Set working directory
WORKDIR /app

# Copy package files first (for better Docker layer caching)
COPY package*.json ./

# Install Node.js dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Create minecraft-server directory and set permissions
RUN mkdir -p minecraft-server/plugins && \
    chmod -R 755 minecraft-server

# Expose ports
EXPOSE 3000 25565 19132

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV MINECRAFT_PORT=25565
ENV BEDROCK_PORT=19132

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Start the application
CMD ["npm", "start"]
