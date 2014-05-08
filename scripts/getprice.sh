#!/bin/sh

wget -qO- http://google.com/finance?q=$1 | grep -A1 'itemprop="price"' | tail -1 | sed -E 's/^.*"(.*)".*$/\1/'
