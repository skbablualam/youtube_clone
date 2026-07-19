# -----------------------------
# Stage 1 - Build React App
# -----------------------------
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN CI=false npm run build

# -----------------------------
# Stage 2 - Nginx
# -----------------------------
FROM nginx:alpine

# Copy the built files
COPY --from=builder /app/build /usr/share/nginx/html

# COPY your custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx","-g","daemon off;"]