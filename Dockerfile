FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig

ADD https://services.gradle.org/distributions/gradle-5.4-bin.zip /opt/gradle/
RUN unzip -d /opt/gradle /opt/gradle/gradle-5.4-bin.zip \
    && ls /opt/gradle/gradle-5.4
ENV PATH=$PATH:/opt/gradle/gradle-5.4/bin

ADD https://s3.us-east-2.amazonaws.com/gavintest-k8s-cluster/jdk-9.0.4_linux-x64_bin.tar.gz /opt/jdk
RUN tar -xvf /opt/jdk/jdk-9_linux-x64_bin.tar.gz -C /opt/jdk
ENV JAVA_HOME /opt/jdk/jdk-9.0.4
ENV PATH $PATH:$JAVA_HOME/bin