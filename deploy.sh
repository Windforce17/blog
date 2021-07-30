#!/usr/bin/env bash
# Push HTML files to gh-pages automatically.

# Fill this out with the correct org/repo
ORG=Windforce17
REPO=blog
# This probably should match an email for one of your users.
EMAIL=wzcboss@qq.com

set -e

git remote add gh-token "https://${GH_TOKEN}@github.com/$ORG/$REPO.git";
git fetch gh-token && git fetch gh-token gh-pages:gh-pages;

# Update git configuration so I can push.
if [ "$1" != "dry" ]; then
    # Update git config.
    git config user.name "Travis Builder"
    git config user.email "$EMAIL"
fi

mkdocs gh-deploy -v --clean --remote-name gh-token;