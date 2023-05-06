#!/bin/bash

NC='\033[0m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

BUILD_DIR="build"

usage() {
  echo ""
  echo "Usage: $0 -t BUILD_TYPE -g GENERATOR"
  echo -e "\t-t\t-type\t--type:"
  echo -e "\t\t\t\t\tDebug - Build project with Debugflags."
  echo -e "\t\t\t\t\tDebugFull - Build project with Debug (Debugfull) flags."
  echo -e "\t\t\t\t\tRelease - Build project with Release flags."
  echo -e "\t-g\t-generator\t--generator:"
  echo -e "\t\t\t\t\tSpecify a build system generator.\n"
  echo -e "\t-h\t-help\t--help:\t\t Display this information\n"
  echo -e "\t-D:\t\t\t\t Equivalent to \"-D\" on cmake, usage: -D <VARIABLE>=<VALUE>\n"
  echo -e "\t-c\t-clean\t--clean:\t Deletes the cmake build folder\n"
  exit 1
}

check_build_type() {
  lower_case_type="${type,,}"
  if [ "${lower_case_type}" == "test" ]; then
    BUILD_DIR="${BUILD_DIR}/test"
    type="Debug"
  elif [ "${lower_case_type}" == "debugfull" ]; then
    BUILD_DIR="${BUILD_DIR}/debugfull"
    type="DebugFull"
  elif [ "${lower_case_type}" == "release" ]; then
    BUILD_DIR="${BUILD_DIR}/release"
    type="Release"
  else
    BUILD_DIR="${BUILD_DIR}/debug"
    type="Debug"
  fi
}

while [ $# -gt 0 ]; do
  case "$1" in
    -t | -type | --type)
      type="$2"
      check_build_type
      ;;
    -g | -gen | --gen | -generator | --generator)
      generator="$2"
      ;;
    -h | -help | --help)
      usage
      exit 0
      ;;
    -D)
      aditional_flags=${aditional_flags}"-D$2 "
      ;;
    -c | -clean | --clean)
      echo -e "${YELLOW}Deleting build folder. ${NC}"
      rm -rf build
      exit 0
      ;;
    *)
      echo -e "${RED}Error: Invalid argument. ${NC}"
      usage
      exit 1
      ;;
  esac
  shift
  shift
done

BUILD_TYPE="${type:-Debug}"
GENERATOR="${generator:-Unix Makefiles}"
CMAKE_ADITIONAL="${aditional_flags:--DEXAMPLES=OFF}"

if [ "${lower_case_type}" == "test" ]; then
  echo -e "${YELLOW}Building unit-tests with ${BUILD_TYPE} configuration.${NC}"
  CMAKE_CMD='cmake -H"${PROJECT_DIR}/test" \
    -B"${BUILD_DIR}" \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE="Debug" \
    "${CMAKE_ADITIONAL}"'

else
  echo -e "${YELLOW}Building for ${BUILD_TYPE} configuration.${NC}"

  CMAKE_CMD='cmake -H"${PROJECT_DIR}" \
    -B"${BUILD_DIR}" \
    -G "${GENERATOR}" \
    -DCMAKE_TOOLCHAIN_FILE="${PROJECT_DIR}/cmake/Toolchain-${COMPILER_PREFIX}.cmake" \
    -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
    "${CMAKE_ADITIONAL}"'
fi

eval "${CMAKE_CMD}"

cmake --build "${BUILD_DIR}" -- -j3
