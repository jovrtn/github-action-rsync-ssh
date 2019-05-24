#!/bin/sh -l

set -e

: ${SSH_KEY_PRIVATE?Required secret not set.}
: ${SSH_KEY_PUBLIC?Required secret not set.}

SSH_PATH="$HOME/.ssh"
WPENGINE_HOST="git.wpengine.com"
KNOWN_HOSTS_PATH="$SSH_PATH/known_hosts"
SSH_KEY_PRIVATE_PATH="$SSH_PATH/deploy_key"
SSH_KEY_PUBLIC_PATH="$SSH_PATH/deploy_key.pub"

mkdir "$SSH_PATH"

ssh-keyscan -t rsa "$HOST_NAME" >> "$KNOWN_HOSTS_PATH"

echo "$SSH_KEY_PRIVATE" > "$SSH_KEY_PRIVATE_PATH"
echo "$SSH_KEY_PUBLIC" > "$SSH_KEY_PUBLIC_PATH"

chmod 700 "$SSH_PATH"
chmod 644 "$KNOWN_HOSTS_PATH"
chmod 600 "$SSH_KEY_PRIVATE_PATH"
chmod 644 "$SSH_KEY_PUBLIC_PATH"

rsync -r -a -v -u -e "ssh -i $SSH_KEY_PRIVATE_PATH -o UserKnownHostsFile=$KNOWN_HOSTS_PATH" --delete --exclude .ssh $* $GITHUB_WORKSPACE $HOST_USER@$HOST_NAME:$HOST_PATH
