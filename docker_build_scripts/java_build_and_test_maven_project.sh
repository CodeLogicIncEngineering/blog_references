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
docker run --rm                        \
  -i -t                                \
  --workdir /tmp/app/                  \
  --volume ~/.m2/:/tmp/.m2/            \
  --user `id -u`:`id -g`               \
  --volume $INCLUDES/:/tmp/app/        \
  -e MAVEN_CONFIG=/tmp/.m2             \
  maven:3.6.3-jdk-11                   \
  sh -c 'mvn clean install -am -U -Dmaven.repo.local=/tmp/.m2/repository/ -Duser.home=/tmp'
