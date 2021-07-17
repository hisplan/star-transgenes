#!/bin/bash

docker login
docker tag cromwell-fai2gtf:0.2.0 hisplan/cromwell-fai2gtf:0.2.0
docker push hisplan/cromwell-fai2gtf:0.2.0
