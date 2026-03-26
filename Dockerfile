# Use official Node.js image
FROM node:18-alpine

# Create app directory inside container
WORKDIR /app

# Copy package files first (for caching optimization)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining application code
COPY . .

# Expose application port
EXPOSE 3000

# Environment variable (optional)
ENV APP_NAME="Vijay DevOps Portfolio"

# Start the application
CMD ["npm", "start"]
