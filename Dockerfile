FROM adoptopenjdk/openjdk8-openj9:slim

# Env setup
ENV VELOCITY_JAR_URL=https://ci.velocitypowered.com/job/velocity/55/artifact/proxy/build/libs/velocity-proxy-1.0-SNAPSHOT-all.jar

WORKDIR /app/proxy

COPY proxy_files /app/proxy

# Download Velocity

RUN apt-get update && apt-get install -y wget && \
    wget -O /app/proxy/velocity.jar $VELOCITY_JAR_URL && \
    chown -R 1000 /app/* && \
    java -jar velocity.jar

# Run Server
USER 1000
EXPOSE 25565
ENTRYPOINT ["bash"]
CMD ["/app/proxy/start.sh"]