#!/usr/bin/env bash

# This is a reliable way to get the full path to the bash script.
# https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
if [[ -z ${INCLUDES+x} ]]; then
    pushd `dirname $0` > /dev/null
    DIR=`pwd`
    popd > /dev/null
    INCLUDES="$DIR"
fi

# Check our blog for a detailed description about how this works.
# https://info.codelogic.com/blog
docker run --rm                                           \
  --user `id -u`:`id -g`                                  \
 --workdir /app/                                          \
 --volume $INCLUDES/:/app/                                \
 node:14                                                  \
 sh -c "npm install && npm test"
