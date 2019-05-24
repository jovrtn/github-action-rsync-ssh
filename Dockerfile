FROM debian:9.7-slim

LABEL "com.github.actions.name"="GitHub Action for rsync over SSH"
LABEL "com.github.actions.description"="An action to deploy your repository workspace via rsync over SSH."
LABEL "com.github.actions.icon"="chevrons-right"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/jovrtn/github-action-rsync-ssh"
LABEL "maintainer"="Jesse L.K. Overton <jesse@ovrtn.com>"

RUN apt-get update && \
apt-get install -y \
openssh-client \
rsync && \
rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
