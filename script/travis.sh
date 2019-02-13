#!/bin/sh
set -e
RUBYCRITICLIMIT=${RUBYCRITICLIMIT:-"90.0"}

bundle exec rspec
bundle exec rubocop
gem install bundler-audit && bundle-audit update && bundle-audit check
gem install rubycritic && rubycritic app lib config ${RUBYCRITICPARAMS} --format console --minimum-score ${RUBYCRITICLIMIT}
echo "Pushing badges upstream"
[ -d badges ] || mkdir badges
cp coverage/coverage_badge* badges/ 2>/dev/null || true
