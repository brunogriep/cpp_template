#!/bin/bash

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

if [ ! "$(command -v clang-tidy)" ]; then
  echo -e "${RED}Please, install clang-tidy for running the code formatter. (apt install clang-tidy).${NC}"
  exit 1
fi

if [ ! "$(command -v parallel)" ]; then
  echo -e "${RED}Please, install parallel for running the code formatter (apt install parallel).${NC}"
  exit 1
fi

BUILD_DIR="$(pwd)/build"
FILENAME="clang-tidy.txt"
PATHS_TO_CHECK="src"
FILES=$(find ${PATHS_TO_CHECK} -name "*.*" | grep -E "(\.c$|\.cc$|\.cpp$|\.h$|\.hpp$)")

echo -e "${YELLOW}Starting Clang-Tidy Static Analysis... ${NC}"

parallel -m clang-tidy -header-filter='^external' --format-style=file -p "${BUILD_DIR}" {} ::: "${FILES}" | tee "${FILENAME}"
python3 -m clang_html "${FILENAME}"

echo -e "${YELLOW}Clang-Tidy Static Analysis report saved in the file ${FILENAME}. ${NC}"
