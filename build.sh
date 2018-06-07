#!/bin/bash
rm *.html

for file in *.md
do
    PREFIX=$(basename "$file" | cut -d. -f1)
    pandoc $file -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "$PREFIX.html" --template ./templates/template.html
    #pandoc $file -w html -o "$PREFIX.html" --template ./templates/template.html
done

