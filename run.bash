#!/bin/bash 

if [ "$1" == "" ]; then
	echo "Usage: 'bash run.bash 2', where 2 is the max number of processes"
    exit
fi

echo -e "\n****************************************************"
echo "*                              _                   *"
echo "*                             | | (_)              *" 
echo "*    ___  ____   ___ ____ ____| |_ _  ___  ____    *"
echo "*   / _ \|  _ \ / _ \  __/ _  | __| |/ _ \|  _ \   *"
echo "*  | (_) | |_) |  __/ | | (_| | |_| | (_) | | | |  *"
echo "*   \___/|  __/ \___|_|  \__,_|\__|_|\___/|_| |_|  *"
echo "*        | |                                       *"
echo "*        |_|                                       *"
echo "*                             _                    *"
echo "*                          (_) |                   *"
echo "*           ___  ____ ____  _| |_ _   _            *"
echo "*          / __|/ _  |  _ \| | __| | | |           *"
echo "*          \__ \ (_| | | | | | |_| |_| |           *"
echo "*          |___/\__,_|_| |_|_|\__|\__, |           *"
echo "*                                  __/ |           *"
echo "*                                 |___/            *"
echo "****************************************************"
echo -e "\nPlease note that running this script with more processes can significantly improve test time."
echo -e "The script takes approximately an hour with two processes."
echo -e "Additionally, the script runs best when you have no instances and projects on your Atmosphere account!\n"

# sets PROCESSES to first argument
PROCESSES=$1

# STEP 1: LAUNCH INSTANCES
echo -e "********************************************"
echo -e "********| STEP 1: LAUNCH INSTANCES |********"
echo -e "********************************************"
echo -e "'p' indicates pass and 'f' indicates fail."
echo -e "Not all 'f's indicate failure here. Check to see if failed tests still launched the instance.\n"
behave --processes $PROCESSES --parallel-element scenario features/launch.feature

# STEP 2: ENSURE INSTANCES ARE ACTIVE
echo -e "\n*********************************************************"
echo -e "********| # STEP 2: ENSURE INSTANCES ARE ACTIVE |********"
echo -e "*********************************************************"
echo -e "Failures here can indicate deployment errors."
echo -e "'p' indicates pass and 'f' indicates fail.\n"
behave --processes $PROCESSES --parallel-element scenario features/check.feature

# STEP 3: TEST VOLUMES, LINKS, TICKETS
echo -e "\n*********************************************************"
echo -e "********| STEP 3: TEST VOLUMES, LINKS, TICKETS |*********"
echo -e "*********************************************************"
echo -e "Any red text here can be interpreted as failure.\n"
behave features/test.feature

# STEP 4: CLEAN UP
echo -e "\n************************************"
echo -e "********| STEP 4: CLEAN UP |********"
echo -e "************************************"
echo -e "Manual cleanup is usually necessary in addition to this command"
echo -e "'p' indicates pass and 'f' indicates fail.\n"
behave --processes $PROCESSES --parallel-element scenario features/cleanup.feature