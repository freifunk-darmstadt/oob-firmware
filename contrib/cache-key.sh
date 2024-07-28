#!/bin/bash

WORKSPACE_DIR="$1"
SDK_URL="$2"

if [ -z "$WORKSPACE_DIR" ] || [ -z "$SDK_URL" ]; then
    echo "Usage: $0 <workspace_dir> <sdk_url>"
    exit 1
fi

PACKAGES_SUBMODULE_REV="$(git -C "$WORKSPACE_DIR/packages" rev-parse HEAD)"
SDK_URL_HASH="$(echo "$SDK_URL" | sha256sum | cut -d ' ' -f 1)"
CACHE_KEY="$PACKAGES_SUBMODULE_REV-$SDK_URL_HASH"

echo "$CACHE_KEY"
