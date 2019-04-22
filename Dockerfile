FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig

ADD https://services.gradle.org/distributions/gradle-5.4-bin.zip /opt/gradle/
RUN unzip -d /opt/gradle /opt/gradle/gradle-5.4-bin.zip \
    && ls /opt/gradle/gradle-5.4
ENV PATH=$PATH:/opt/gradle/gradle-5.4/bin

# ADD https://download.oracle.com/otn/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz /opt/jdk/
ADD https://download.java.net/openjdk/jdk9/ri/openjdk-9+181_linux-x64_ri.zip /opt/jdk/
RUN unzip -d /opt/jdk /opt/jdk/openjdk-9+181_linux-x64_ri.zip
# RUN ls /opt/jdk/java-se-9-ri
# ENV JAVA_HOME=/opt/jdk/java-se-9-ri/jdk-9
RUN echo $PATH
RUN whereis java

# ENV PATH=$PATH:$JAVA_HOME/bin
RUN export JAVA_HOME=/opt/jdk/java-se-9-ri/jdk-9  >> /etc/profile\
    && export JRE_HOME=${JAVA_HOME}/jre  >> /etc/profile\
    && export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  >> /etc/profile\
    && export  PATH=${JAVA_HOME}/bin:$PATH \
    && source /etc/profile

RUN java -version