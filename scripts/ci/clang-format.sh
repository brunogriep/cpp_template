#!/bin/bash

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

if [ ! "$(command -v clang-format)" ]; then
  echo -e "${RED}Please, install clang-format for running the code formatter. (apt install clang-format).${NC}"
  exit 1
fi

if [ ! "$(command -v parallel)" ]; then
  echo -e "${RED}Please, install parallel for running the code formatter (apt install parallel).${NC}"
  exit 1
fi

DIRECTORIES=("src" "test")

echo -e "${YELLOW}Formatting files with clang-format... ${NC}"

for dir in "${DIRECTORIES[@]}"; do
  FILES=$(find "${dir}" -name "*.*" | grep -E "(\.c$|\.cc$|\.cpp$|\.h$|\.hpp$)")
  parallel -m clang-format --verbose -i -style=file ::: "${FILES}"
done
