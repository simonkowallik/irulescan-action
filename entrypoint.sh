#!/bin/sh
#set -e

#https://github.com/orgs/community/discussions/26288#discussioncomment-3876281
delimiter=$(cat /proc/sys/kernel/random/uuid)
echo "result<<${delimiter}" >> $GITHUB_OUTPUT

exit_code=0

# Set custom file extensions if provided
if [[ -n "$INPUT_FILE_EXTENSIONS" ]]; then
    export IRULESCAN_FILE_EXTENSIONS="$INPUT_FILE_EXTENSIONS"
fi

# run default commands when no args/CMD provided
if [[ -z "$1" ]];
then
    if [[ -z "$INPUT_EXPECTED_RESULTS_FILE" ]];
    then
        cd $(realpath ${GITHUB_WORKSPACE}/${INPUT_SCANDIR})
        irulescan check . > /tmp/results.json
        exit_code=$?
        echo "$(cat /tmp/results.json)" >> $GITHUB_OUTPUT
        echo "$(cat /tmp/results.json)"
    else
        cd $(realpath ${GITHUB_WORKSPACE}/${INPUT_SCANDIR})
        irulescan checkref $(realpath ${GITHUB_WORKSPACE}/${INPUT_EXPECTED_RESULTS_FILE}) > /tmp/diff.txt
        exit_code=$?
        echo "$(cat /tmp/diff.txt)" >> $GITHUB_OUTPUT
        echo "$(cat /tmp/diff.txt)"
    fi
else
    cd $(realpath ${GITHUB_WORKSPACE})
    echo $(exec $@) > /tmp/output.txt
    exit_code=$?
    echo "$(cat /tmp/output.txt)" >> $GITHUB_OUTPUT
    echo "$(cat /tmp/output.txt)"
fi
echo "${delimiter}" >> $GITHUB_OUTPUT

exit $exit_code
