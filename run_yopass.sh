#!/bin/bash

# Start memcached in the background
memcached -u memcache &

# Start the yopass server 
#/yopass-server --memcached=127.0.0.1:11211 --port 80 > /dev/null 2>&1
/yopass-server --memcached=127.0.0.1:11211 --port 80
