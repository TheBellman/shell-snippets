#!/usr/bin/env bash

CURRENT=$(pwd)

OIFS="$IFS"
IFS=$'\n'
for DIR in $(find . -type d -name .git -exec dirname {} \;)
do
  cd ${DIR}

  case "$(basename $0)" in
    "status.sh")
      echo "==========================================================================================" ;
      pwd;
      git status
      ;;
    "branch.sh")
      echo "$(pwd) - $(git rev-parse --abbrev-ref HEAD)"
      ;;
    "update.sh")
      echo "==========================================================================================" ;
      pwd;
      git pull --all
      ;;
    "remote.sh")
      echo "==========================================================================================" ;
      pwd ;
      git remote -v
      ;;
    *)
      ;;
  esac

  cd ${CURRENT}
done
