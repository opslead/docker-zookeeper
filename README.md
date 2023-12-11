# Apache Zookeeper Container Image

[![Docker Stars](https://img.shields.io/docker/stars/opslead/zookeeper.svg?style=flat-square)](https://hub.docker.com/r/opslead/zookeeper) 
[![Docker Pulls](https://img.shields.io/docker/pulls/opslead/zookeeper.svg?style=flat-square)](https://hub.docker.com/r/opslead/zookeeper)

#### Docker Images

- [GitHub actions builds](https://github.com/opslead/docker-zookeeper/actions) 
- [Docker Hub](https://hub.docker.com/r/opslead/zookeeper)


#### Environment Variables
When you start the Zookeeper image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the docker run command line. The following environment values are provided to custom Zookeeper:

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `JAVA_ARGS`               |               | Configure JVM params            |
| `ZOOKEEPER_TICK_TIME`     | 2000          | Tick time                       |
| `ZOOKEEPER_INIT_LIMIT`    | 10            | Init limim                      |
| `ZOOKEEPER_SYNC_LIMIT`    | 5             | Sync limit                      |
| `ZOOKEEPER_CLIENT_PORT`   | 2181          | Client port                     |


#### Run the Service

```bash
docker service create --name zookeeper \
  -p 2181:2181 \
  -e JAVA_ARGS="-Xms2G -Xmx6G" \
  opslead/zookeeper:latest
```

When running Docker Engine in swarm mode, you can use `docker stack deploy` to deploy a complete application stack to the swarm. The deploy command accepts a stack description in the form of a Compose file.

```bash
docker stack deploy -c zookeeper-stack.yml zookeeper
```

Compose file example:
```
version: "3.8"
services:
  zookeeper:
    image: opslead/zookeeper:latest
    ports:
      - 2181:2181
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      environment:
        - JAVA_ARGS=-Xms2G -Xmx6G

```

# Contributing
We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/opslead/docker-zookeeper/issues), or submit a [pull request](https://github.com/opslead/docker-zookeeper/pulls) with your contribution.

# Issues
If you encountered a problem running this container, you can file an [issue](https://github.com/opslead/docker-zookeeper/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version
- Output of docker info
- Version of this container
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)
