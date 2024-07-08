#!/bin/bash

# Start the yopass server 
/yopass-server --database redis --redis "redis://${REDIS_URL}0" --port 80 --force-onetime-secrets --log-level=debug
