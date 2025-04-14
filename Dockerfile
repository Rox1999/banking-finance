FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Run stage
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/star-agile-banking-finance-*.jar star-agile-banking-finance.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "star-agile-banking-finance.jar"]
