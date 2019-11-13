#!/bin/bash

docker login
docker tag cromwell-star:2.5.3a hisplan/cromwell-star:2.5.3a
docker push hisplan/cromwell-star:2.5.3a
