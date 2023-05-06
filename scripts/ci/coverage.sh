#!/bin/bash

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

if [ ! "$(command -v gcovr)" ]; then
  echo -e "${RED}Please, install gcovr (pip install gcovr)${NC}"
  exit 1
fi

echo -e "${YELLOW}Generating Coverage Report for cobertura (XML) format...${NC}"
(cd "${PROJECT_DIR}" \
  && gcovr -r "${PROJECT_DIR}" "${BUILD_DIR}" --print-summary \
    --xml-pretty -o "${PROJECT_DIR}"/coverage.xml)

echo -e "${YELLOW}Generating Coverage Report for SonarQube format...${NC}"
(cd "${PROJECT_DIR}" \
  && gcovr -r "${PROJECT_DIR}" "${BUILD_DIR}" --print-summary \
    --sonarqube -o "${PROJECT_DIR}"/coverage-sonar.xml)

echo -e "${YELLOW}Generating Coverage Report for HTML format...${NC}"
(cd "${PROJECT_DIR}" \
  && gcovr -r "${PROJECT_DIR}" "${BUILD_DIR}" --print-summary \
    --html-details -o "${PROJECT_DIR}"/coverage.html)

echo -e "${YELLOW}Generating Coverage Report for TXT format...${NC}"
(cd "${PROJECT_DIR}" \
  && gcovr -r "${PROJECT_DIR}" "${BUILD_DIR}" --print-summary \
    --txt -o "${PROJECT_DIR}"/coverage.txt)
