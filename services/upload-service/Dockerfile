FROM node:18-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .


# Expose port
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV UPLOAD_DIR=/storage
ENV UPLOAD_MAX_SIZE=104857600

# Create upload directory
RUN mkdir -p /storage

# Start the application
CMD ["npm", "start"]
