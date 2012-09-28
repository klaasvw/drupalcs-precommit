#!/usr/bin/env sh

# Git precommit hook for validating drupal coding standards.
#
# This script will validate all staged files against the drupal coding
# standards. In order to use this script you need to have the following
# software installed:
# - drush <http://drupal.org/project/drush>
# - drupalcs <http://drupal.org/project/drupalcs>

DRUPALCS_FILE_PATTERN="\.(php|module|inc|install|test|profile|theme)$"

# Initial check to see if all requirements to run this script are met.
# Check if drush exists and is executable.
if ! command -v drush >/dev/null 2>&1; then
  echo "Drush bin not found or executable."
  exit 1
fi
# Check if the drupal code sniffer drush plugin is available.
if ! drush dcs -hq; then
  echo "The drush drupalcs module has not been installed."
  exit 1
fi

# Stash the current changes so only the staged code is evaluated.
git stash -q --keep-index
# Exit when one check fails.
RETVAL=0
# Collect the output.
OUTPUT=""
# Check each file in the staging area.
for FILE in $(git diff --cached --name-only --diff-filter=ACRM); do
  # Check against whitelist.
  echo $FILE | egrep -q $DRUPALCS_FILE_PATTERN
  if [ $? -eq 0 ]; then
    drush dcs $FILE;
    [ $? -ne 0 ] && RETVAL=1
  fi;
done
# Unstash the changes to go back to the current working tree.
git stash pop -q

exit $RETVAL
