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
echo -e "\nPlease note that running this script with more processes can significantly decrease test time."
echo -e "The script takes approximately 50 minutes with two processes.\n"

# sets PROCESSES to first argument
PROCESSES=$1

# STEP 1: LAUNCH INSTANCES
echo -e "\n********| Launching featured images |********"
echo "Failures here can be false negatives. Investigate failed scenarios to see if the instances launched.\n"
behave --processes $PROCESSES --parallel-element scenario features/launch.feature

# STEP 2: ENSURE INSTANCES ARE ACTIVE
echo -e "\n********| Ensuring instances become active |********"
echo -e "Failures here can indicate deployment errors. Investigate any failed tests.\n"
behave --processes $PROCESSES --parallel-element scenario features/check.feature

# STEP 3: TEST VOLUMES, LINKS, TICKETS
echo -e "\n********| Testing volumes, links, and ticketing |********"
echo -e "Any red text here can be interpreted as failure. Investigate the issue to ensure everything is working.\n"
behave  features/test.feature

# STEP 4: CLEAN UP
echo -e "\n********| Cleaning up |********"
echo -e "Manual cleanup is usually necessary in addition to this command\n"
behave --processes $PROCESSES --parallel-element scenario features/cleanup.feature