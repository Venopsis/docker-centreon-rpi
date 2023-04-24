#!/bin/bash
echo "--------"
echo "Running the container" $(hostname)
echo "Time info :" $(date)
echo "--------"
if [ "$1" = "install" ]
    then
        # Run the installation script.
        echo $(date) "- Installation mode initiated"
        chmod +x centreon_central.sh
        ./centreon_central.sh
elif [ "$1" = "start" ]
    then
        echo $(date) "- Centreon service : starting"
        echo $(date) "- Centreon service : running"
        # Command below keep container running after tmux command done
        tail -f /dev/null
else
    echo $(date) "- !! ERROR !! This container does not accept other arguments than 'init' and 'start'"
    exit 1
fi
