#!/bin/bash

# NAME: cutspace.sh
# USAGE: ./cutspace.sh [param(str)]
# FUNCTION: Replace spaces in file names with underscores.

# looping & file generating - as specified in step b
for file in {1..10}
do
        name="${RANDOM} ${RANDOM}"
        touch ./"${name}"
done

# looping & replacing ( ) with (_) - as specified in step a
for file in ./*
do
        if [ -f "$file" ]
        then
                `mv "$file" "${file// /_}"` # replace all occurences (double '//')
        fi
done
