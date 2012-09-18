#!/usr/bin/env sh

# Git precommit hook for validating drupal coding standards.
#
# This script will validate all staged files against the drupal coding
# standards. In order to use these scripts you need to have the following
#
# software installed:
# - drush <http://drupal.org/project/drush>
# - drupalcs <http://drupal.org/project/drupalcs>

# An array of file extensions drupalcs should check.
EXTENSIONS='php|txt|inc|info|test|profile|module|engine'

# Stash the current changes so only the staged code is evaluated.
git stash -q --keep-index
# Fetch an overview of all staged files.
files=$(git status --porcelain);
# Loop over each staged file and check it with drupalcs.
for staged_file in $files; do
  echo $staged_file
done

# Unstash the changes to go back to the current working tree.
git stash pop -q
