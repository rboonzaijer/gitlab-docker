#!/bin/bash

echo ""
echo "Gitlab: UPDATE"

echo "-> docker compose pull"
docker compose pull

echo "-> docker compose up -d --remove-orphans"
docker compose up -d --remove-orphans
