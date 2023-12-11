FROM azul/zulu-openjdk:11

LABEL maintainer="opslead"
LABEL repository="https://github.com/opslead/docker-zookeeper"

WORKDIR /opt/zookeeper

ENV ZOOKEEPER_USER="zookeeper" \
    ZOOKEEPER_UID="8983" \
    ZOOKEEPER_GROUP="zookeeper" \
    ZOOKEEPER_GID="8983" \
    ZOOKEEPER_VERSION="3.9.1" \
    ZOOKEEPER_DIST_URL="https://dlcdn.apache.org/zookeeper/zookeeper-3.9.1/apache-zookeeper-3.9.1-bin.tar.gz"

ENV ZOOKEEPER_TICK_TIME=2000 \
    ZOOKEEPER_INIT_LIMIT=10 \
    ZOOKEEPER_SYNC_LIMIT=5 \
    ZOOKEEPER_CLIENT_PORT=2181

RUN groupadd -r --gid "$ZOOKEEPER_GID" "$ZOOKEEPER_GROUP"
RUN useradd -r --uid "$ZOOKEEPER_UID" --gid "$ZOOKEEPER_GID" "$ZOOKEEPER_USER"
RUN apt-get -y update && apt-get -y install curl
RUN curl -L $ZOOKEEPER_DIST_URL --output /tmp/apache-zookeeper.tar.gz; \
    tar -C /tmp --extract --file /tmp/apache-zookeeper.tar.gz; \
    rm /tmp/apache-zookeeper.tar.gz; \
    mv /tmp/apache-zookeeper-* /tmp/zookeeper; \
    mv /tmp/zookeeper/lib /opt/zookeeper/; \
    rm -rf /opt/zookeeper/lib/*.txt; \
    mkdir -p /opt/zookeeper/data; \
    chown $ZOOKEEPER_USER:$ZOOKEEPER_GROUP -R /opt/zookeeper

COPY entrypoint /opt/zookeeper
COPY logback.xml /opt/zookeeper
RUN chmod +x /opt/zookeeper/entrypoint

USER $ZOOKEEPER_USER
VOLUME ["/opt/zookeeper/data"]

ENTRYPOINT ["/opt/zookeeper/entrypoint"]