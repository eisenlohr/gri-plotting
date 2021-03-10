#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT="$( basename "${BASH_SOURCE[0]}" )"
BASE=$( [[ $SCRIPT =~ plot_(.*)\.sh ]] && echo ${BASH_REMATCH[1]} )
DATA="$DIR/../data/${BASE}.txt.bz2"
FIGURE="$DIR/../../gallery/${BASE}"

cmd=()
for what in 3 2 1
do
  cmd+=( "$DATA" "normal@${what}"      "${what}" red )
  cmd+=( "$DATA" "exponential@${what}" "${what}" blue )
done

gri -p -output "${FIGURE}.ps" \
 $GRI/plot_distribution \
 colormap own \
 label \
 clip \
 aspect 0.5 \
 frame inch 4 \
 linear 'value' %g -9 9 6 3 1 \
 "${cmd[@]}"

gri_ps2pdf "${FIGURE}.ps"
