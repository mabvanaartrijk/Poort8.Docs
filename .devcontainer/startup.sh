#!/usr/bin/env bash
set -euo pipefail

# Install Ruby gems locally
bundle config set --local path 'vendor/bundle'
bundle install --jobs 4 --retry 3

# Build the site and run tests
bundle exec jekyll build --source docs --trace
bundle exec htmlproofer ./_site --disable-external
