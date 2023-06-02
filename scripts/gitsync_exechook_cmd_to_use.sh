#!/bin/sh
# this script will be executed in active path ${GIT_SYNC_ROOT}/(hash)
# assuming it can write and erase path /dags_dest

# unless v level of git-sync is set to 6, echo message will not be shown in docker console.

# Empty the /dags_dest directory
if [ "$(ls -A /tmp/from-github)" ]; then
    echo "/dags_dest is not empty. Removing all files and directories."
    rm -rf /repo/*
fi

# Copy everything under the active directory to /dags_dest
cp -R . /repo
cp -R /repo /conftest-code

echo "Files copied to /dags_dest."
