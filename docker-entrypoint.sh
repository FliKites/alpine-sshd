#!/bin/shif [ -z "${AUTHORIZED_KEYS}" ]; then \  echo "Need your ssh public key as AUTHORIZED_KEYS env variable. Abnormal exit ..."
  exit 1
fi

echo "Populating /root/.ssh/authorized_keys with the value from AUTHORIZED_KEYS env variable ..."
echo "${AUTHORIZED_KEYS}" > /root/.ssh/authorized_keys

    apk update \
    && apk add openssh \
    && mkdir /root/.ssh \
    && chmod 0700 /root/.ssh \
    && ssh-keygen -A \
    && sed -i s/^#PasswordAuthentication\ yes/PasswordAuthentication\ no/ /etc/ssh/sshd_config \
    && sed -i "s/#Port 22/Port ${PORT}/" /etc/ssh/sshd_config \
# Execute the CMD from the Dockerfile:
exec "$@"
