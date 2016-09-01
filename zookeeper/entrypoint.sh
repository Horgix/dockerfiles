#!/bin/sh

echo "${MYID:-1}" > /tmp/zookeeper/myid

# based on https://github.com/apache/zookeeper/blob/trunk/conf/zoo_sample.cfg
cat > /opt/zookeeper/conf/zoo.cfg <<EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/tmp/zookeeper
clientPort=2181
EOF

# server.1=...
if [ -n "$SERVERS" ]; then
    #printf '%s' "$SERVERS" | awk 'BEGIN { RS = "," }; { printf "server.%i=%s:2888:3888\n", NR, $0 }' >> /opt/zookeeper/conf/zoo.cfg
    echo -n "$SERVERS" | sed 's/,/\n/g' | sed 's/\([0-9]\+\):\(.*\)/server.\1=\2:2888:3888/' >> /opt/zookeeper/conf/zoo.cfg
    echo '' >> /opt/zookeeper/conf/zoo.cfg
fi

exec "$@"
