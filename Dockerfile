FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig

ADD https://services.gradle.org/distributions/gradle-5.4-bin.zip /opt/gradle/
RUN unzip -d /opt/gradle /opt/gradle/gradle-5.4-bin.zip \
    && ls /opt/gradle/gradle-5.4
ENV PATH=$PATH:/opt/gradle/gradle-5.4/bin

# # ADD https://download.oracle.com/otn/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz /opt/jdk/
# ADD http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz /opt/jdk/
# # RUN unzip -d /opt/jdk /opt/jdk/openjdk-9+181_linux-x64_ri.zip
RUN wget http://download.oracle.com/otn-pub/java/jdk/9+181/jdk-9_linux-x64_bin.tar.gz -O /opt/jdk/jdk-9_linux-x64_bin.tar.gz
RUN tar -zxvf /opt/jdk/jdk–9_linux–x64_bin.tar.gz -C /opt/jdk
RUN alternatives –install /usr/bin/java java /opt/jdk/jdk-9/bin/java 2
# # RUN ls -al /usr/bin/java
# # RUN rm -rf /usr/bin/java
# # RUN ln /opt/jdk/java-se-9-ri/bin/java /usr/bin/java
# RUN ls -al /opt/jdk/jdk-9.0.4
# RUN java -version
# RUN ls -al /usr/bin/java
# RUN rm /usr/bin/java \
#     && ln -s /usr/lib/jvm/jdk-9.0.4/bin/java /usr/bin/java
# RUN ls -al /usr/bin/java
# RUN ln /opt/jdk/jdk-9.0.4/bin/java /usr/bin/java
ENV JAVA_HOME=/opt/jdk/jdk-9
# ENV CLASSPATH=:$CLASSPATH:$JAVA_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin
# RUN echo $PATH
# RUN export JAVA_HOME=/opt/jdk/jdk-9.0.4  >> /etc/profile \
#     && export  PATH=${JAVA_HOME}/bin:$PATH >> /etc/profile \
#     && source /etc/profile \
#     && java -version

# RUN java -version