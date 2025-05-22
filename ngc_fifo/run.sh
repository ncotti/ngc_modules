#!/bin/bash

if [ ! -d tmp ]; then
    mkdir tmp
fi

vsim -c -do run.do