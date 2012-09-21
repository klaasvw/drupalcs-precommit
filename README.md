drupalcs-precommit
==================

Git pre commit hook for checking modified files with Drupal Code Sniffer.

## Installation

- Download or clone this repository to any location.
- Make a symbolic link from the git repistory's hook directory to drupalcs.sh, named pre-commit: 'ln -s /path/to/drupalcs.sh .git/hooks/pre-commit'

## Usage
- Commit your changes.
- The drupalcs.sh file will be exected and checks all modified files.
- Your commit will abort when drupalcs found errors and show the output.
