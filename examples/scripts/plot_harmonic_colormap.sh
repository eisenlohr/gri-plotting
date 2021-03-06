#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT="$( basename "${BASH_SOURCE[0]}" )"
BASE=$( [[ $SCRIPT =~ plot_(.*)\.sh ]] && echo ${BASH_REMATCH[1]} )
DATA="$DIR/../data/${BASE}.txt"
FIGURE="$DIR/../../gallery/${BASE}"

cmd=()
for what in tan cos sin
do
  cmd+=( $(columns 'x' "${what}(x)" "$DATA") "${what}" )
done

gri -p -output "${FIGURE}.ps" \
 $GRI/plot \
 line solid \
 colormap green \
 label initial \
 secondx \
 linear '$x$' %g 0 6.283 0 4 \
 gap -999999 \
 clip \
 frame inch 2 \
 linear '$x / \pi$' %g 0 2 2 6 $(echo '1/3.1415926' | bc -l) \
 linear '$f(x)$' %g -5 5 2 5 1 \
 "${cmd[@]}"

gri_ps2pdf "${FIGURE}.ps"
