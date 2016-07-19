#!/bin/bash 

PROCESSES = "$1"

echo "launching featured images"
behave --processes $PROCESSES --parallel-element scenario features/launch.feature
echo "done"

echo "waiting 30 minutes for deployment to complete"
sleep 1800

echo "checking featured images"
behave --processes $PROCESSES --parallel-element scenario features/test.feature
echo "done"

echo "cleaning up"
behave --processes $PROCESSES --parallel-element scenario features/cleanup.feature
echo "done"