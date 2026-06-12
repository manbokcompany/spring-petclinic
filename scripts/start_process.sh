#!/bin/bash

# cd /home/ubuntu/scripts
# docker compose up -d
docker run -itd -p 80:8080 --name=myweb s4616/myweb
