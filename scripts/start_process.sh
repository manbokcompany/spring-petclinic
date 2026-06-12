#!/bin/bash

# cd /home/ubuntu/scripts
# docker compose up -d
docker run -itd -p 80:80 --name=myweb s4616/myweb
