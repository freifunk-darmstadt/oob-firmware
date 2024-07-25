#!/bin/bash


BASE_VERSION="1.0.0"

# Name of SDK
SDK_NAME="openwrt-sdk-23.05.4-ath79-nand_gcc-12.3.0_musl.Linux-x86_64"

# Name of Imagebuilder
IMAGEBUILDER_NAME="openwrt-imagebuilder-23.05.4-ath79-nand.Linux-x86_64"

# URLs
SDK_URL="https://downloads.openwrt.org/releases/23.05.4/targets/ath79/nand/${SDK_NAME}.tar.xz"
IMAGEBUILDER_URL="http://downloads.openwrt.org/releases/23.05.4/targets/ath79/nand/${IMAGEBUILDER_NAME}.tar.xz"

# Get Git short hash for repo at $SCRIPT_DIR
GIT_SHORT_HASH="$(git -C "$SCRIPT_DIR" rev-parse --short HEAD)"

# Get date of last Git commit for repo at $SCRIPT_DIR
GIT_COMMIT_DATE="$(git -C "$SCRIPT_DIR" log -1 --format=%cd --date=format:'%Y%m%d')"

# Get latest Git tag for repo at $SCRIPT_DIR
GIT_LATEST_TAG="$(git describe --tags --abbrev=0)"

# Use the base version as the version prefix
VERSION_PREFIX="$BASE_VERSION"

# Use the latest tag as the version prefix if it exists
if [ -n "$GIT_LATEST_TAG" ]; then
    # If there is a tag, use it as the version prefix
    VERSION_PREFIX="$GIT_LATEST_TAG"
fi

# Don't create a release by default
CREATE_RELEASE="0"

# Check if this was a push of a tag
if [ "$GITHUB_EVENT_NAME" = "push"  ] && [ "$GITHUB_REF_TYPE" = "branch" ]; then
  VERSION="$VERSION_PREFIX-$GIT_SHORT_HASH-$GIT_COMMIT_DATE"
elif [ "$GITHUB_EVENT_NAME" = "push" ] && [ "$GITHUB_REF_TYPE" = "tag" ]; then
  # If this was a push of a tag, use the tag as the version
  VERSION="$VERSION_PREFIX"
  CREATE_RELEASE="1"
else
  # Error out, unsupported
  exit 1
fi

# Write build-meta to dedicated file before appending GITHUB_OUTPUT.
# This way, we can create an artifact for our build-meta to eventually upload to a release.
BUILD_META_TMP_DIR="$(mktemp -d)"
BUILD_META_OUTPUT="$BUILD_META_TMP_DIR/build-meta.txt"

echo "firmware-version=$VERSION" > "$BUILD_META_OUTPUT"
echo "create-release=$CREATE_RELEASE" >> "$BUILD_META_OUTPUT"
echo "build-meta-output=$BUILD_META_TMP_DIR" >> "$BUILD_META_OUTPUT"
echo "sdk-name=$SDK_NAME" >> "$BUILD_META_OUTPUT"
echo "sdk-url=$SDK_URL" >> "$BUILD_META_OUTPUT"
echo "imagebuilder-name=$IMAGEBUILDER_NAME" >> "$BUILD_META_OUTPUT"
echo "imagebuilder-url=$IMAGEBUILDER_URL" >> "$BUILD_META_OUTPUT"


# Copy over to GITHUB_OUTPUT
cat "$BUILD_META_OUTPUT" >> "$GITHUB_OUTPUT"

# Display Output so we can conveniently check it from CI log viewer
cat "$GITHUB_OUTPUT"

exit 0
