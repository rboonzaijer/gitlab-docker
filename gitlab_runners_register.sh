#!/bin/bash

# get variables from .env file
export $(grep -v '^#' .env | xargs)

docker run --rm -v gitlab_runner_1:/etc/gitlab-runner gitlab/gitlab-runner register \
  --description "gitlab_runner_1" \
  --tag-list "docker,gitlab_runner_1" \
  --maintenance-note "" \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "${external_url}" \
  --registration-token "${runner_token}" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

docker run --rm -v gitlab_runner_2:/etc/gitlab-runner gitlab/gitlab-runner register \
  --description "gitlab_runner_2" \
  --tag-list "docker,gitlab_runner_2" \
  --maintenance-note "" \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "${external_url}" \
  --registration-token "${runner_token}" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

docker run --rm -v gitlab_runner_3:/etc/gitlab-runner gitlab/gitlab-runner register \
  --description "gitlab_runner_3" \
  --tag-list "docker,gitlab_runner_3" \
  --maintenance-note "" \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "${external_url}" \
  --registration-token "${runner_token}" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
