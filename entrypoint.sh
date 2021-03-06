#!/bin/sh

set -e

: ${SSH_KEY_PRIVATE?Required secret not set.}
: ${SSH_KEY_PUBLIC?Required secret not set.}

SSH_PATH="$HOME/.ssh"
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

sh -c "rsync -r -a -v -u --delete -e \"ssh -i $SSH_KEY_PRIVATE_PATH -o UserKnownHostsFile=$KNOWN_HOSTS_PATH\" $*"
