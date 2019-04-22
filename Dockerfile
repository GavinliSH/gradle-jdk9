FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig

ADD https://services.gradle.org/distributions/gradle-5.4-bin.zip /opt/gradle/
RUN unzip -d /opt/gradle /opt/gradle/gradle-5.4-bin.zip \
    && ls /opt/gradle/gradle-5.4
ENV PATH=$PATH:/opt/gradle/gradle-5.4/bin

ARG OPENJDK9_ALPINE_URL=http://download.java.net/java/jdk9-alpine/archive/181/binaries/serverjre-9-ea+181_linux-x64-musl_bin.tar.gz

# Download and untar openjdk9-alpine from $OPENJDK9_ALPINE_URL
RUN mkdir -p /usr/lib/jvm \
  && wget -c -O- --header "Cookie: oraclelicense=accept-securebackup-cookie" $OPENJDK9_ALPINE_URL \
    | tar -zxC /usr/lib/jvm
    
# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV JAVA_HOME /usr/lib/jvm/jdk-9
ENV PATH $PATH:$JAVA_HOME/bin