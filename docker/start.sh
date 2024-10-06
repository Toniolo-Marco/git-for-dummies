#!/bin/bash

set -eux

# fetch a short-lived runner registration token for the org
reg_token=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $RUNNER_MANAGER_TOKEN" \
  https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/registration-token | jq -r .token)

/bin/bash config.sh --unattended --url https://github.com/${REPO_OWNER}/${REPO_NAME} --name ${RUNNER_NAME} --work _work --token ${reg_token} --labels typst,self-hosted

remove () {
  local rem_token=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $RUNNER_MANAGER_TOKEN" \
  https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/remove-token | jq -r .token)

  ./config.sh remove --token $rem_token
}

trap remove EXIT

./bin/runsvc.sh
