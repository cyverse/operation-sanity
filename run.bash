#!/bin/bash 

if [ "$1" == "" ]; then
	echo "Usage: 'bash run.bash 2', where 2 is the max number of processes"
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
echo "                             _                  "
echo "                          (_) |                 "
echo "           ___  ____ ____  _| |_ _   _          "
echo "          / __|/ _  |  _ \| | __| | | |         "
echo "          \__ \ (_| | | | | | |_| |_| |         "
echo "          |___/\__,_|_| |_|_|\__|\__, |         "
echo "                                  __/ |         "
echo "                                 |___/          "

PROCESSES=$1

echo -e "\n********| Launching featured images |********"
behave --processes $PROCESSES --parallel-element scenario features/launch.feature

echo -e "\n********| Ensuring instances become active |********"
behave --processes $PROCESSES --parallel-element scenario features/check.feature

echo -e "\n********| Testing volumes, links, and ticketing |********"
behave  features/test.feature

echo -e "\n********| Cleaning up |********"
behave --processes $PROCESSES --parallel-element scenario features/cleanup.feature