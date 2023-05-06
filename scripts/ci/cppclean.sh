#!/bin/bash

NC='\033[0m'
YELLOW='\033[1;33m'

# CppClean - https://github.com/myint/cppclean

CPPCLEAN_FILE="cppclean.txt"
DIRECTORIES=("boards" "external")

for dir in "${DIRECTORIES[@]}"; do
  EXCLUSIONS+="--exclude ${dir} "
done

echo -e "${YELLOW}Generating cppclean report and saving in the ${CPPCLEAN_FILE} file.${NC}"

CPPCLEAN="cppclean ${EXCLUSIONS} ."
bash -c "${CPPCLEAN} | tee ${CPPCLEAN_FILE}"
