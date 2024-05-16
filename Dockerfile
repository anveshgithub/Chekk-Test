FROM eclipse-temurin:17-jdk-alpine  

WORKDIR /app  

COPY MySpring_Boot_aa23v_VotingApp_Final/target/*.jar app.jar  

EXPOSE 8080  

ENTRYPOINT ["java", "-jar", "app.jar"]  
