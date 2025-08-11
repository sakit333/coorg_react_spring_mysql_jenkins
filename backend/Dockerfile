# Use OpenJDK base image
FROM openjdk:17-jdk-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy pom.xml and install dependencies (Maven build)
COPY pom.xml .

# Download dependencies (this layer will be cached if unchanged)
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the Spring Boot application (package JAR)
RUN mvn clean package -DskipTests

# Step 2: Run the Spring Boot application
FROM openjdk:17-jdk-slim

# Set the location of the JAR file
COPY --from=build /app/target/*.jar app.jar

# Expose port for Spring Boot app
EXPOSE 8081

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app.jar"]
