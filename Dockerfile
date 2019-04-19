FROM gocd/gocd-agent-docker-dind:v19.2.0

RUN chown -R go:go /home/go
COPY --chown=go:go config/.gitconfig /home/go/.gitconfig
