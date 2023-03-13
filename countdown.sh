#!/bin/bash

function countdown {
    for i in {60..0} # 60 to 0
    do
        echo -e $i '\e[1A\e[K seconds' # overwriting on the same line
    done
}

countdown
