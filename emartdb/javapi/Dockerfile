# Stage 1: Build Maven project
FROM maven:3.8.4-openjdk-8-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire Maven project to the working directory
COPY . .

# Run Maven install to build the project
RUN mvn install -DskipTests 

# Stage 2: Create final image with artifacts
FROM openjdk:8-slim

# Set the working directory inside the container
WORKDIR /app

# Copy artifacts from the build stage to the final image
COPY --from=build /app/target/*.jar /app/

# Expose 9000 port
EXPOSE 9000

# Command to run your application
CMD ["java", "-jar", "/app/book-work-0.0.1-SNAPSHOT.jar"]
