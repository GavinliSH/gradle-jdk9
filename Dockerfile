FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig

ADD https://services.gradle.org/distributions/gradle-5.4-bin.zip /opt/gradle/
RUN unzip -d /opt/gradle /opt/gradle/gradle-5.4-bin.zip \
    && ls /opt/gradle/gradle-5.4
ENV PATH=$PATH:/opt/gradle/gradle-5.4/bin