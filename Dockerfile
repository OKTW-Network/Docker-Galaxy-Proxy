FROM adoptopenjdk/openjdk8-openj9:slim

# Env setup
ENV VELOCITY_JAR_URL=https://ci.velocitypowered.com/job/velocity/55/artifact/proxy/build/libs/velocity-proxy-1.0-SNAPSHOT-all.jar

WORKDIR /app/proxy

COPY proxy_files /app/proxy

# Download mcrcon
RUN apt-get update && apt-get install -y wget && \
    wget -q -O - "https://github.com/OKTW-Network/mcrcon/releases/download/v0.0.6/mcrcon-0.0.6-linux-x86-64.tar.gz" | tar xz -C /app/control/ mcrcon && \
    apt-get purge -y wget && \
    rm -rf /var/lib/apt/lists/*

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