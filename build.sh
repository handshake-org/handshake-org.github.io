#!/bin/bash
mkdir -p output
rm output/*.html

for file in *.md
do
    PREFIX=$(basename "$file" | cut -d. -f1)
    pandoc $file -T $PREFIX -V "pagetitle:$PREFIX" -V "title:$PREFIX" -w html5 -o "output/$PREFIX.html" --template ./templates/template.html
    #pandoc $file -w html -o "$PREFIX.html" --template ./templates/template.html
done

