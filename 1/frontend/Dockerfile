# Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
# First install to generate package-lock.json if it doesn't exist
RUN npm install
# Then install dependencies
RUN npm ci --only=production
COPY src/ ./src/
COPY public/ ./public/
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Nginx configuration
RUN echo 'server { \
    listen 3000; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
