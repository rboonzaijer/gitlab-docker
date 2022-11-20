#!/bin/bash

# get variables from .env file
export $(grep -v '^#' .env | xargs)

docker volume create gitlab_runner_1
docker volume create gitlab_runner_2
docker volume create gitlab_runner_3

docker run -d --name gitlab_runner_1 --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v gitlab_runner_1:/etc/gitlab-runner gitlab/gitlab-runner:latest
docker run -d --name gitlab_runner_2 --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v gitlab_runner_2:/etc/gitlab-runner gitlab/gitlab-runner:latest
docker run -d --name gitlab_runner_3 --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v gitlab_runner_3:/etc/gitlab-runner gitlab/gitlab-runner:latest
