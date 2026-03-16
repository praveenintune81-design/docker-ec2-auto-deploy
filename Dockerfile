# Use official Node.js base image
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy package.json to container
COPY app/package.json .

# Install Node.js dependencies
RUN npm install

# Copy application source code
COPY app .

# Expose container port
EXPOSE 3000

# Start the application
CMD ["npm","start"]
