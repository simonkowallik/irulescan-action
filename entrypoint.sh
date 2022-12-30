#!/usr/bin/env bash
set -e

#https://github.com/orgs/community/discussions/26288#discussioncomment-3876281
delimiter=$(cat /proc/sys/kernel/random/uuid)
echo "result<<${delimiter}" >> $GITHUB_OUTPUT

# run default commands when no args are provided
if [[ -z "$1" ]];
then

    /scandir.sh $(realpath ${GITHUB_WORKSPACE}/${INPUT_SCANDIR}) > /results.yaml

    if [[ -z "$INPUT_EXPECTED_RESULTS_FILE" ]];
    then
        echo "$(cat /results.yaml)" >> $GITHUB_OUTPUT
        cat /results.yaml
    else
        echo $(diff --ignore-blank-lines --ignore-trailing-space --ignore-space-change $INPUT_EXPECTED_RESULTS_FILE /results.yaml) > output.txt
        echo "$(cat output.txt)" >> $GITHUB_OUTPUT
        cat output.txt
    fi
else
    echo $(exec $@) > output.txt
    echo "$(cat output.txt)" >> $GITHUB_OUTPUT
    cat output.txt
fi
echo "${delimiter}" >> $GITHUB_OUTPUT

