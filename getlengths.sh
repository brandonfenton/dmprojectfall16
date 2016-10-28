#!/bin/bash

echo "Finding BirdCLEF sound lengths:"
for i in $( ls wav/ ); do
	echo $i, $(soxi -D wav/$i) >>lengths.csv
	echo $i
done
