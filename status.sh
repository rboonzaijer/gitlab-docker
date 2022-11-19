#!/bin/bash

echo ""
echo "Gitlab: STATUS"

echo "-> docker ps --filter \"name=gitlab\""
docker ps --filter "name=gitlab"
