FROM node:18-alpine

# Install OpenJDK 21
RUN apk add --no-cache openjdk21-jre

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install npm dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Create minecraft-server directory
RUN mkdir -p minecraft-server/plugins

# Expose ports
EXPOSE 3000 25565 19132

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV MINECRAFT_PORT=25565
ENV BEDROCK_PORT=19132

# Start the application
CMD ["npm", "start"]
