ARG STRATUS_COMMIT="d5f48abcffbb2d401b3556002c6b825b581f4e48"


FROM maven:3-openjdk-11 AS STRATUS_BUILDER

ARG STRATUS_COMMIT

RUN apt-get update \
    && apt-get install -y --no-install-recommends git

RUN cd /tmp \
  && git clone https://github.com/planetlabs/stratus.git \
  && cd stratus \
  && git checkout ${STRATUS_COMMIT}

RUN cd /tmp/stratus/src \
  && mvn clean package -Dgdal -DskipTests


FROM ubuntu:bionic

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-11-jre-headless \
        libgdal-java

COPY --from=STRATUS_BUILDER /tmp/stratus/src/stratus-application/target/stratus-application-exec.jar .
RUN touch /tmp/s3.properties

ENTRYPOINT ["java", "-jar", "-Duser.timezone=GMT", "/stratus-application-exec.jar"]
