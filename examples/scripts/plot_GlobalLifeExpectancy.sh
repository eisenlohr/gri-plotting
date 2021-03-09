#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT="$( basename "${BASH_SOURCE[0]}" )"
BASE=$( [[ $SCRIPT =~ plot_(.*)\.sh ]] && echo ${BASH_REMATCH[1]} )
DATA="$DIR/../data/${BASE}.txt"
FIGURE="$DIR/../../gallery/${BASE}"

gri -p -output "${FIGURE}.ps" \
 $GRI/plot \
 line solid \
 linewidth 0.5 \
 symbol dot \
 color 'rgb 0.45 0.10 0.45' \
 label outside \
 aspect 0.5 \
 frame inch 2 \
 linear 'year' %g 1750 2050 6 5 1 \
 log 'life expectancy / a' %g 10 100 2 1 1 \
 "$DATA" Year LifeExpectancy/a world \

gri_ps2pdf "${FIGURE}.ps"
