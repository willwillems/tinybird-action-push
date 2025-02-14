#!/bin/sh -l

: "${TOKEN?Tinybird token not found, please check README.md.}"
: "${HOST?Tinybird host not found, please check README.md.}"
: "${GITHUB_WORKSPACE?GITHUB_WORKSPACE has to be set. Did you use the actions/checkout action?}"
: "${GITHUB_SHA?GITHUB_SHA has to be set. Did you use the actions/checkout action?}"

git config --global --add safe.directory $GITHUB_WORKSPACE

# Revert fetch with depth=1, so eveything is collpased to one single commit
git pull --unshallow


FORCE=""
NOCHECK=""
POPULATE=""


# Force flag
if echo $INPUT_FORCE | grep -iqF true; then
  FORCE="--force"
fi

# No check
if echo $INPUT_NOCHECK | grep -iqF true; then
  NOCHECK="--no-check"
fi

# Populate flag
if echo $INPUT_POPULATE | grep -iqF true; then
  POPULATE="--populate"
fi


cd $INPUT_DIRECTORY


# Print command
echo "tb --token "${TOKEN}" --host "${HOST}" push ${FORCE} ${NOCHECK} ${POPULATE}"
tb --token "${TOKEN}" --host "${HOST}" push ${FORCE} ${NOCHECK} ${POPULATE}

