#!/usr/bin/env sh

# Git precommit hook for validating drupal coding standards.
#
# This script will validate all staged files against the drupal coding
# standards. In order to use this script you need to have the following
# software installed:
# - drush <http://drupal.org/project/drush>
# - drupalcs <http://drupal.org/project/drupalcs>

# Stash the current changes so only the staged code is evaluated.
git stash -q --keep-index
# Exit when one check fails.
exit_status=0
# Check each file in the staging area
for result in $(git diff --cached --name-only --diff-filter=AM); do
  drush dcs --extensions=php,module,inc,install,test,profile,theme $result
  [ $? -ne 0 ] && exit_status=1
done
# Unstash the changes to go back to the current working tree.
git stash pop -q

exit $exit_status
