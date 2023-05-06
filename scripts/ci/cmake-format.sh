#!/bin/bash

# https://github.com/cheshirekow/cmake_format

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

if [ ! "$(command -v cmake-format)" ]; then
  echo -e "${RED}Please, install cmake-format for running the code formatter. (apt install cmake-format).${NC}"
  exit 1
fi

if [ ! "$(command -v parallel)" ]; then
  echo -e "${RED}Please, install parallel for running the code formatter (apt install parallel).${NC}"
  exit 1
fi

echo -e "${YELLOW}Formatting CMakeLists files with cmake-format... ${NC}"

FILES=$(find ./ -name "CMakeLists.txt" -not -path "./external/*")
parallel -m cmake-format -i -c .cmake-format ::: "${FILES}"
