FROM adoptopenjdk/openjdk11-openj9:alpine

# Env setup
USER 1000
COPY --chown=1000 proxy_files /app/proxy
WORKDIR /app/proxy

# Download Velocity
ADD --chown=1000 https://ci.velocitypowered.com/job/velocity/59/artifact/proxy/build/libs/velocity-proxy-1.0-SNAPSHOT-all.jar velocity.jar

# Run Server
EXPOSE 25565
ENTRYPOINT ["java"]
CMD ["-jar", "velocity.jar"]
