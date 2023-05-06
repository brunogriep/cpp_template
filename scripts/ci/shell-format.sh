#!/bin/bash

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

if [ ! "$(command -v shfmt)" ]; then
  echo -e "${RED}Please, install shfmt for running the shell scripts formatter. (snap install shfmt).${NC}"
  exit 1
fi

if [ ! "$(command -v parallel)" ]; then
  echo -e "${RED}Please, install parallel for running the code formatter (apt install parallel).${NC}"
  exit 1
fi

echo -e "${YELLOW}Formatting files with shfmt... ${NC}"

FILES=$(find ./scripts -name "*.*" | grep -E "(\.sh$)")
parallel -m shfmt -i 2 -ci -bn -w ::: "${FILES}"
