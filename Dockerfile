From eclipse-temurin:21-jre-alpine
ARG JAR_FILE_PATH=target/*.jar
COPY ${JAR+FILE_PATH} spring-petclinic.jar
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
