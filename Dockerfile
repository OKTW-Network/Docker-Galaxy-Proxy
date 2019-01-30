FROM adoptopenjdk/openjdk11:slim

# Env setup
ENV VELOCITY_JAR_URL=https://ci.velocitypowered.com/job/velocity/55/artifact/proxy/build/libs/velocity-proxy-1.0-SNAPSHOT-all.jar

WORKDIR /app/proxy

COPY proxy_files /app/proxy

# Download Velocity

RUN apt-get update && apt-get install -y wget && \
    wget -O /app/proxy/velocity.jar $VELOCITY_JAR_URL && \
    java -jar velocity.jar && \
    chown -R 1000 /app/*

# Run Server
USER 1000
EXPOSE 25577
ENTRYPOINT ["bash"]
CMD ["/app/proxy/start.sh"]
