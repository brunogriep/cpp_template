#!/bin/bash

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

CXX_VERSION="c++2a"
C_VERSION="c11"
FILENAME="cppcheck.xml"
HTML_PATH="$(pwd)/cppcheck"
PATHS_TO_CHECK="src"

echo -e "${YELLOW}Starting CppCheck report... ${NC}"

cppcheck "./${PATHS_TO_CHECK}" -I . --enable=all \
  --inconclusive --library=posix --std="${C_VERSION}" \
  --xml-version=2 2>"${FILENAME}"

cppcheck-htmlreport --file="${FILENAME}" --report-dir="${HTML_PATH}" --source-dir=.

echo -e "${YELLOW}CppCheck XML report saved in the file ${FILENAME}. ${NC}"
echo -e "${YELLOW}CppCheck HTML report saved in the file ${HTML_PATH}/index.html ${NC}"
