FROM adoptopenjdk/openjdk8-openj9:alpine-jre

# Download Velocity
ADD --chown=1000 https://ci.velocitypowered.com/job/velocity/lastStableBuild/artifact/proxy/build/libs/velocity-proxy-1.0.0-SNAPSHOT-all.jar /app/proxy/velocity.jar

COPY --chown=1000 proxy_files /app/proxy

# Run Server
USER 1000
WORKDIR /app/proxy
EXPOSE 25565
CMD ["java", "-jar", "velocity.jar"]
