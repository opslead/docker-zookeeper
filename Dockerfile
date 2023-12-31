FROM azul/zulu-openjdk:11

LABEL maintainer="opslead"
LABEL repository="https://github.com/opslead/docker-zookeeper"

ARG ZOOKEEPER_VERSION

WORKDIR /opt/zookeeper

ENV ZOOKEEPER_USER="zookeeper" \
    ZOOKEEPER_UID="8983" \
    ZOOKEEPER_GROUP="zookeeper" \
    ZOOKEEPER_GID="8983" \
    ZOOKEEPER_TICK_TIME=2000 \
    ZOOKEEPER_INIT_LIMIT=10 \
    ZOOKEEPER_SYNC_LIMIT=5 \
    ZOOKEEPER_CLIENT_PORT=2181

COPY entrypoint /opt/zookeeper
COPY logback.xml /opt/zookeeper

RUN groupadd -r --gid "$ZOOKEEPER_GID" "$ZOOKEEPER_GROUP"
RUN useradd -r --uid "$ZOOKEEPER_UID" --gid "$ZOOKEEPER_GID" "$ZOOKEEPER_USER"

RUN apt-get update && \
    apt-get -y install curl && \
    curl -f -L https://dlcdn.apache.org/zookeeper/zookeeper-$ZOOKEEPER_VERSION/apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz --output /tmp/apache-zookeeper.tar.gz && \
    tar xf /tmp/apache-zookeeper.tar.gz -C /tmp && \
    mv /tmp/apache-zookeeper-$ZOOKEEPER_VERSION-bin/lib /opt/zookeeper/ && \
    rm -rf /opt/zookeeper/lib/*.txt /tmp/* &&  \
    mkdir -p /opt/zookeeper/data && \
    chown $ZOOKEEPER_USER:$ZOOKEEPER_GROUP -R /opt/zookeeper && \
    chmod +x /opt/zookeeper/entrypoint && \
    apt-get clean

USER $ZOOKEEPER_USER
VOLUME ["/opt/zookeeper/data"]

ENTRYPOINT ["/opt/zookeeper/entrypoint"]