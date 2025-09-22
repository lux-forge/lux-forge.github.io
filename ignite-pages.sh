#!/bin/bash
# ignite-pages.sh — Branded deployment script for LuxForge
# Features: dry-run mode, build stamping, metadata injection, and GitHub Pages push

set -e

# Configurable variables
REPO_DIR="$HOME/luxforge-blog"              # Path to your repo
BUILD_DIR="$REPO_DIR/_site"            # Jekyll output directory
STAMP_FILE="$REPO_DIR/_includes/build-stamp.html"
DRY_RUN=false
BRANCH="main"
REMOTE="origin"

# Branding metadata
BUILD_DATE=$(date +"%Y-%m-%d %H:%M:%S")
COMMIT_HASH=$(git -C "$REPO_DIR" rev-parse --short HEAD)
TAGLINE="Forged with purpose — $BUILD_DATE ($COMMIT_HASH)"

# Parse arguments
for arg in "$@"; do
  case $arg in
    --dry-run) DRY_RUN=true ;;
    --branch=*) BRANCH="${arg#*=}" ;;
    --remote=*) REMOTE="${arg#*=}" ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done

echo "🔥 Igniting LuxForge deployment..."
echo "→ Repo: $REPO_DIR"
echo "→ Branch: $BRANCH"
echo "→ Dry-run: $DRY_RUN"

# Inject build stamp
echo "<!-- $TAGLINE -->" > "$STAMP_FILE"
echo "✓ Build stamp injected: $TAGLINE"

# Build site
cd "$REPO_DIR"
bundle exec jekyll build
echo "✓ Jekyll build complete"

# Dry-run preview
if $DRY_RUN; then
  echo "🧪 Dry-run mode active — skipping git push"
  echo "Preview available at: file://$BUILD_DIR/index.html"
  exit 0
fi

# Commit and push
git add "$STAMP_FILE"
git commit -m "Deploy: $TAGLINE"
git push "$REMOTE" "$BRANCH"
echo "🚀 Deployment pushed to $REMOTE/$BRANCH"

# Open GitHub Pages site
SITE_URL="https://luxforge.dev"
echo "🌐 Opening deployed site: $SITE_URL"
xdg-open "$SITE_URL" 2>/dev/null || open "$SITE_URL" || echo "Please visit: $SITE_URL"

echo "✅ LuxForge ignition complete."