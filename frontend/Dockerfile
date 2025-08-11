# Step 1: Build the React application
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the React app source code
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the build using Nginx
FROM nginx:alpine

# Copy the build output to Nginx's default directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that Nginx listens on
EXPOSE 80

# Run Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
