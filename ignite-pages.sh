#!/bin/bash

# ┌────────────────────────────────────────────┐
# │ LuxForge Deployment Script: ignite-pages.sh │
# └────────────────────────────────────────────┘

set -e

SOURCE_REPO="https://github.com/lux-forge/luxforge.blog.source.git"
BLOG_REPO="https://github.com/lux-forge/lux-forge.github.io.git"
BUILD_DIR="_site"
DEPLOY_DIR="../luxforge-blog-output"
STAMP=$(date +"%Y-%m-%d %H:%M:%S")
VERSION="LuxForge v1.0.0"
DRY_RUN=false
LOG_MESSAGE="Deploy: $VERSION — $STAMP"

# ─── Parse flags ─────────────────────────────
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --dry-run) DRY_RUN=true ;;
    --log) LOG_MESSAGE="$2"; shift ;;
    --version) VERSION="$2"; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
  shift
done

# ─── Build site ──────────────────────────────
echo "🔨 Building site from source…"
bundle exec jekyll build

# ─── Prepare deploy repo ─────────────────────
echo "📦 Preparing blog deployment repo…"
rm -rf $DEPLOY_DIR
git clone $BLOG_REPO $DEPLOY_DIR

# ─── Copy built site ─────────────────────────
echo "🚚 Copying built site to deploy repo…"
rsync -av --delete --exclude='.git' $BUILD_DIR/ $DEPLOY_DIR/

# ─── Commit and push ─────────────────────────
cd $DEPLOY_DIR
git config user.name "lux-forge"
git config user.email "luxforge@users.noreply.github.com"

if $DRY_RUN; then
  echo "🧪 Dry run mode: skipping commit and push"
  echo "Would commit: $LOG_MESSAGE"
else
  echo "🚀 Committing and pushing to blog repo…"
  git add -A
  git commit -m "$LOG_MESSAGE"
  git push origin main
  echo "✅ Deployed: $LOG_MESSAGE"
fi