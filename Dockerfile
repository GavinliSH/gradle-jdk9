FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig

ADD https://services.gradle.org/distributions/gradle-5.4-bin.zip /opt/gradle/
RUN unzip -d /opt/gradle /opt/gradle/gradle-5.4-bin.zip \
    && ls /opt/gradle/gradle-5.4
ENV PATH=$PATH:/opt/gradle/gradle-5.4/bin

# ADD https://download.oracle.com/otn/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz /opt/jdk/
ADD https://download.java.net/openjdk/jdk9/ri/openjdk-9+181_linux-x64_ri.zip /opt/jdk
RUN tar -zxvf -C /opt/java /opt/jdk/jdk-9.0.4_linux-x64_bin.tar.gz
ENV JAVA_HOME=/opt/java/jdk-9
ENV PATH=$PATH:$JAVA_HOME/bin

RUN java -version