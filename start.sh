#!/bin/bash

echo ""
echo "Gitlab: START"

echo "-> docker compose up -d"
docker compose up -d

echo "-> docker ps --filter \"name=gitlab\""
docker ps --filter "name=gitlab"
