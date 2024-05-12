#!/bin/bash

VERSION="8.18.2"

# Check if curl is installed
if command -v curl &>/dev/null; then
  echo "curl is installed."
else
  echo "curl is not installed. Please install curl to proceed."
  exit 1
fi

# Check if tar is installed
if command -v tar &>/dev/null; then
  echo "tar is installed."
else
  echo "tar is not installed. Please install tar to proceed."
  exit 1
fi

# Function to detect the current os
get_os() {
  case "$(uname -s)" in
  Linux*) OS=linux ;;
  Darwin*) OS=darwin ;;
  CYGWIN*) OS=windows ;;
  MINGW*) OS=windows ;;
  *) OS=unknown ;;
  esac
  echo "$OS"
}

# Function to detect the current architecture
get_arch() {
  case "$(uname -m)" in
  x86_64) ARCH=x64 ;;
  i686) ARCH=x32 ;;
  armv6*) ARCH=armv6 ;;
  armv7*) ARCH=armv7 ;;
  aarch64) ARCH=arm64 ;;
  *) ARCH=unknown ;;
  esac
  echo "$ARCH"
}

# Download and install gitleaks
install_gitleaks() {
  OS=$(get_os)
  ARCH=$(get_arch)
  GITLEAKS_FILE="gitleaks_${VERSION}_${OS}_${ARCH}.tar.gz"
  GITLEAKS_URL="https://github.com/gitleaks/gitleaks/releases/download/v${VERSION}/${GITLEAKS_FILE}"
  echo "Downloading gitleaks from $GITLEAKS_URL..."
  curl -sSL "$GITLEAKS_URL" -o "$GITLEAKS_FILE"
  tar -xzf "$GITLEAKS_FILE"
  chmod +x gitleaks
  rm $GITLEAKS_FILE
  echo "Gitleaks installed successfully!"
  ignore_file
}

ignore_file() {
  # Your new file to ignore
  NEW_IGNORED_FILE="gitleaks"

  # Check if .gitignore exists
  if [ -f .gitignore ]; then
    # Check if the entry already exists in .gitignore
    if grep -q "$NEW_IGNORED_FILE" .gitignore; then
      echo "$NEW_IGNORED_FILE is already in .gitignore"
    else
      # Add the entry to .gitignore
      echo "$NEW_IGNORED_FILE" >>.gitignore
      echo "$NEW_IGNORED_FILE added to .gitignore"
    fi
  else
    echo ".gitignore file not found."
  fi
}

if ! command -v ./gitleaks &>/dev/null; then
  echo "gitleaks not found."
  echo "install getleaks start"
  install_gitleaks
fi
