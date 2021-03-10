#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NAME="$(basename "${BASH_SOURCE[0]%.*}")"
me=${NAME#plot_}
DATA="$DIR/../data/${me%_*}.txt"
FIGURE="$DIR/../../gallery/${me}"

gri -p -output ${FIGURE}.ps \
 $GRI/plot \
 line own \
 symbol own \
 color own \
 label initial \
 secondx linear '$x$ / degree' %g 0 360 6 6 \
 frame inch 2 \
 linear '$x / \pi$' %g 0 2 2 6 $(echo '1/3.1415926' | bc -l) \
 linear '$f(x)$' %g -1 1 2 5 1 \
 "$DATA" 'x' 'sin(x)' sin solid none red \
 "$DATA" 'x' 'cos(x)' cos none dot blue \

gri_ps2pdf ${FIGURE}.ps
