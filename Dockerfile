FROM node:16-alpine as builder

WORKDIR '/app'
# Copy just the dependency file and install
COPY ./package.json .
RUN npm install

# Copy all necessary files to build
COPY . .

# Build production version
RUN npm run build

FROM nginx as production


# Copy only necessary build dir to ngnix default serving folder
COPY --from=builder /app/build /usr/share/nginx/html

# nginx image starts automatically 