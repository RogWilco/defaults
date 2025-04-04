#!/usr/bin/env bash

set -e

# Color codes
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m" # No Color

if [ $# -lt 1 ]; then
  echo -e "${RED}✘${NC} Error: Missing extension directory argument"
  echo "  Usage: bin/validate.sh <extension-directory>"
  exit 1
fi

EXTENSION_DIR="$1"
ROOT_DIR="$(pwd)"
SCHEMA_PATH="${ROOT_DIR}/etc/config.schema.json"

# Get extension name for logging
EXTENSION_NAME=$(basename "${EXTENSION_DIR}")
echo "Validating extension: ${EXTENSION_NAME}"

# Check if extension directory exists
if [ -d "${EXTENSION_DIR}" ]; then
  echo -e "  ${GREEN}✓${NC} Directory Exists"
else
  echo -e "  ${RED}✘${NC} Directory Not Found"
  exit 1
fi

# Check if config.json exists
CONFIG_PATH="${EXTENSION_DIR}/config.json"
if [ -f "${CONFIG_PATH}" ]; then
  echo -e "  ${GREEN}✓${NC} Config Exists"
else
  echo -e "  ${RED}✘${NC} Config Not Found"
  exit 1
fi

# Check if glyph.svg exists
GLYPH_PATH="${EXTENSION_DIR}/glyph.svg"
if [ -f "${GLYPH_PATH}" ]; then
  echo -e "  ${GREEN}✓${NC} Glyph Exists"
else
  echo -e "  ${RED}✘${NC} Glyph Not Found"
  exit 1
fi

# Validate config.json against schema
if bunx ajv-cli validate -s "${SCHEMA_PATH}" -d "${CONFIG_PATH}" &> /dev/null; then
  echo -e "  ${GREEN}✓${NC} Config Schema Valid"
else
  echo -e "  ${RED}✘${NC} Config Schema Invalid"
  exit 1
fi

echo -e "Validation completed successfully!"
