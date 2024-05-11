# Stage 1: Build Angular application
FROM node:14 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install --yes

COPY . .
RUN npm run build -- --prod

# Stage 2: Serve static content using NGINX
FROM nginx:latest

# Remove default NGINX configuration
RUN rm -rf /etc/nginx/conf.d/*

# Copy static content from the build stage to NGINX
COPY --from=build /app/dist/client /usr/share/nginx/html

# Copy custom NGINX configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 4200
EXPOSE 4200

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
