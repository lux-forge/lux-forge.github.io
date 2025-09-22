#!/bin/bash

CONFIG="_config.yml"
CHANGELOG="CHANGELOG.md"
HISTORY=".forge-history"

# Prompt for version bump type
echo "🔧 LuxForge Version Bump"
read -p "Type of bump (major / minor / patch): " BUMP

# Validate input
if [[ "$BUMP" != "major" && "$BUMP" != "minor" && "$BUMP" != "patch" ]]; then
  echo "❌ Invalid bump type. Use: major, minor, or patch."
  exit 1
fi

# Prompt for changelog message
read -p "Changelog message: " MESSAGE

# Extract current version
VERSION=$(grep '^version:' "$CONFIG" | awk '{print $2}')
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"

# Bump version
case $BUMP in
  major) MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0 ;;
  minor) MINOR=$((MINOR + 1)); PATCH=0 ;;
  patch) PATCH=$((PATCH + 1)) ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
BUILD=$(date +"%Y-%m-%d %H:%M BST")
HASH=$(git rev-parse --short HEAD)

# Update _config.yml
sed -i "s/^version: .*/version: $NEW_VERSION/" "$CONFIG"
sed -i "s/^build: .*/build: \"$BUILD\"/" "$CONFIG"
sed -i "s/^commit_hash: .*/commit_hash: $HASH/" "$CONFIG"

# Append to CHANGELOG.md
echo -e "\n## [$NEW_VERSION] - $BUILD\n### Changed\n- $MESSAGE" >> "$CHANGELOG"

# Log to .forge-history
echo "$BUILD | v$NEW_VERSION | $HASH | $MESSAGE" >> "$HISTORY"

# Build site
echo "🔨 Building LuxForge site with Jekyll..."
bundle exec jekyll build || { echo "❌ Build failed"; exit 1; }

# Optional: Clean repo root before copying
echo "🧹 Cleaning old site files..."
find . -maxdepth 1 ! -name '_site' ! -name '.' ! -name '..' ! -name '.git' ! -name '.gitignore' ! -name 'forge-update.sh' ! -name '_config.yml' ! -name 'CHANGELOG.md' ! -name '.forge-history' -exec rm -rf {} +

# Copy built site to repo root
echo "📦 Copying built site to repo root..."
cp -r _site/* .


# Output summary
echo ""
echo "✅ Version bumped to v$NEW_VERSION"
echo "📝 Changelog updated"
echo "📜 Logged to .forge-history"
echo "🔗 Commit hash: $HASH"
echo ""

# Confirm Git commit and push
read -p "Do you want to commit and push these changes? (y/n): " CONFIRM
if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
  git add . "$CHANGELOG" "$HISTORY"
  git commit -m "LuxForge v$NEW_VERSION: $MESSAGE"
  git push
  echo "🚀 Changes pushed to GitHub."
else
  echo "🛑 Git commit skipped. You can push manually later."
fi