#!/bin/bash

BASEDIR=$(dirname "$0")
NC='\033[0m'
YELLOW='\033[1;33m'

PROJECT_DIR="/projectzero"
BASE_IMG_VERSION="latest"
BASE_IMG="project-zero:${BASE_IMG_VERSION}"
DOCKER_BASH="docker run --rm -it -u root --env-file docker/env \
-v $(pwd):${PROJECT_DIR} -w ${PROJECT_DIR} \
${BASE_IMG} bash"

if [ -z "$1" ] || [ "$1" == "open" ]; then
  echo -e "${YELLOW}Generating reports... ${NC}"

  (${DOCKER_BASH} -c "${BASEDIR}/ci/clang-tidy.sh")
  (${DOCKER_BASH} -c "${BASEDIR}/ci/coverage.sh")
  (${DOCKER_BASH} -c "${BASEDIR}/ci/cppcheck.sh")

  echo -e "${YELLOW}Reports generated. ${NC}"
  if [ "$1" == "open" ]; then
    echo -e "${YELLOW}1 ${BROWSER}. ${NC}"

    if [ -x "$(command -v google-chrome)" ]; then
      BROWSER="google-chrome"
      echo -e "${YELLOW}2 ${BROWSER}. ${NC}"
    else
      if [ -x "$(command -v firefox)" ]; then
        BROWSER="firefox"
        echo -e "${YELLOW}3 ${BROWSER}. ${NC}"
      else
        echo -e "${YELLOW}4 ${BROWSER}. ${NC}"
        exit 1
      fi
    fi
    echo -e "${YELLOW}OPENING REPORTS WITH ${BROWSER}. ${NC}"
    ${BROWSER} "file://$(pwd)/clang.html"
    ${BROWSER} "file://$(pwd)/coverage.html"
    ${BROWSER} "file://$(pwd)/cppcheck/index.html"
    ${BROWSER} "file://$(pwd)/cppcheck/stats.html"
  fi

elif [ "$1" == "clean" ]; then
  echo -e "${YELLOW}Cleaning generated reports. ${NC}"

  echo -e "${YELLOW}Cleaning coverage...${NC}"
  rm coverage*

  echo -e "${YELLOW}Cleaning cppcheck...${NC}"
  rm -rf cppcheck
  rm cppcheck.xml

  echo -e "${YELLOW}Cleaning clang-tidy...${NC}"
  rm clang-tidy-checks.py
  rm clang-tidy.txt
  rm clang.html
fi
