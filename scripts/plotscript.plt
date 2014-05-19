set term png
set style data linespoints
set xdata time
set timefmt "%d/%m/%Y_%H:%M"
set format x "%d/%m\n%H:%M"
set xlabel "Date"
set ylabel "Prix"
set title action
set output "../graphs/".action.".png"
plot "../data/".action using 1:2
