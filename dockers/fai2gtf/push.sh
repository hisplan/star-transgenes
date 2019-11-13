#!/bin/bash

docker login
docker tag cromwell-fai2gtf:0.1 hisplan/cromwell-fai2gtf:0.1
docker push hisplan/cromwell-fai2gtf:0.1
