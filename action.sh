#!/bin/bash

# 需要配置环境变量，使得 mvn 可以在命令行中使用

env=$2
if [ -z "$env" ]; then
  env="dev"
fi

package() {
  echo "package $env"
  mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true -P$env
  exit
}

install() {
  echo "install $env"
  mvn clean install -U -DskipTests=true -Dmaven.javadoc.skip=true -P$env
  exit
}

deploy() {
  echo "deploy $env"
  mvn clean deploy -U -DskipTests=true -Dmaven.javadoc.skip=true -P$env
  exit
}

set_version() {
  version=$3
  if [ -z "$version" ]; then
    version=
  fi
  echo "set_version $env $version"
  mvn versions:set -DgenerateBackupPoms=false -DnewVersion="$version$env"
  exit
}

if [ "$1" = "package" ]; then
  package
elif [ "$1" = "install" ]; then
  install
elif [ "$1" = "deploy" ]; then
  deploy
elif [ "$1" = "set_version" ]; then
  set_version
else
  echo "************************************************"
  echo "Usage: action.sh {package|install|deploy|set_version}"
  echo "************************************************"
  exit 1
fi
