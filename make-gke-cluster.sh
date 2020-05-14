#!/usr/bin/env bash

PROJECT="stratus-gcp-0"
ZONE="us-east1-b"
NAME="stratus"

gcloud beta container \
    --project ${PROJECT} \
    clusters create ${NAME} \
    --zone ${ZONE} \
    --machine-type "n1-standard-2" \
    --image-type "COS" \
    --disk-type "pd-standard" \
    --disk-size "100" \
    --num-nodes "3" \
    --enable-autoscaling \
    --min-nodes "1" \
    --max-nodes "5" \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing \
    --release-channel "regular" \
    --enable-autoupgrade \
    --enable-autorepair \
    --max-surge-upgrade 1 \
    --max-unavailable-upgrade 0

