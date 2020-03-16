# Set ubuntu 18.04 as base image
FROM ubuntu:18.04

# Install updates
RUN apt-get update && apt-get -y install software-properties-common

# Install wget, curl, vim
RUN apt-get -y install wget curl vim

# Install Java 11
RUN cd /opt; \
    wget https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz \
    && tar zxf openjdk-11.0.1_linux-x64_bin.tar.gz \
    && ln -s jdk-11.0.1 java \
    && rm -f openjdk-11-ea+25_linux-x64-musl_bin.tar.gz

ENV JAVA_HOME=/opt/java
ENV PATH="$PATH:$JAVA_HOME/bin"

# Install Maven
RUN apt-get -y install maven

# Copy demo-docker-app to user directory
COPY . /usr/local/demo-docker-app/

# Maven install and assemble sample app
RUN cd /usr/local/demo-docker-app && mvn clean install assembly:single

# Execute app
CMD [ "java", "-jar", "/usr/local/demo-docker-app/target/demo-docker-app-1.0-jar-with-dependencies.jar" ] 

