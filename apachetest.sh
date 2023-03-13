#!/bin/bash

function apachetest {
    default_URL='127.0.0.1'
    URL=${1:-${default_URL}}
    if [ 1 ]
        then
            # checking if URL is reachable
            if [ -z `curl -Is http://$URL` ]
            then
                echo "URL unreachable."
                exit 2
            fi
            ab -n 100 -kc 10 ${URL}"/"
        else
            echo "Failed to run. This script requires 'ab' and 'curl' softwares. If you don't have the softwares please execute the following commands to install them; 'sudo apt install apache2-utils' and 'sudo apt install curl'"
            exit 1
    fi
}

apachetest
