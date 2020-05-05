#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NAME="$(basename "${BASH_SOURCE[0]%.*}")"
me=${NAME#plot_}
DATA="$DIR/../data/${me%_*}.txt"
figure="$DIR/../../gallery/${me}"

gri -p -output ${figure}.ps \
 $GRI/plot \
 line solid \
 color own \
 label \
 frame inch 2 \
 linear '$x / \pi$' %g 0 2 2 5 $(echo '1/3.1415926' | bc -l) \
 linear '$f(x)$' %g -1 1 2 5 1 \
 $(columns 'x' 'sin(x)' "$DATA") sin red \
 $(columns 'x' 'cos(x)' "$DATA") cos blue \

gri_ps2pdf ${figure}.ps
