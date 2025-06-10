#!/bin/bash

if ! command -v docker &> /dev/null
then
  echo "❌ Docker is not installed. Please install Docker Desktop."
  exit 1
fi

if ! docker compose version &> /dev/null
then
  echo "❌ Docker Compose v2 is required. Please upgrade Docker."
  exit 1
fi

echo "🚀 Starting KanDesk Pro..."
docker compose up --build
