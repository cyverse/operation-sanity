#!/bin/bash 
PROCESSES=$1

if [ "$1" == "" ]; then
	echo "Usage: bash run.bash 2, where 2 is the max number of processes"
    exit
fi

echo "                              _                 "
echo "                             | | (_)            " 
echo "    ___  ____   ___ ____ ____| |_ _  ___  ____  "
echo "   / _ \|  _ \ / _ \  __/ _  | __| |/ _ \|  _ \ "
echo "  | (_) | |_) |  __/ | | (_| | |_| | (_) | | | |"
echo "   \___/|  __/ \___|_|  \__,_|\__|_|\___/|_| |_|"
echo "        | |                                     "
echo "        |_|                                     "
echo "                               _                "
echo "                            (_) |               "
echo "             ___  ____ ____  _| |_ _   _        "
echo "            / __|/ _  |  _ \| | __| | | |       "
echo "            \__ \ (_| | | | | | |_| |_| |       "
echo "            |___/\__,_|_| |_|_|\__|\__, |       "
echo "                                    __/ |       "
echo "                                   |___/        "


echo "launching featured images"
time behave --processes $PROCESSES --parallel-element scenario features/launch.feature
echo "done"

echo "waiting 30 minutes for deployment to complete"
sleep 1800

echo "testing basic functionality"
behave  features/test.feature
echo "done"

echo "testing web shell"
time behave --processes $PROCESSES --parallel-element scenario features/shell.feature
echo "done"

echo "cleaning up"
time behave --processes $PROCESSES --parallel-element scenario features/cleanup.feature
echo "done"