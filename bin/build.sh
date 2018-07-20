#!/bin/bash
set -e

# enter project root dir
cd `dirname $0`
cd ../

# convert .md to .html files
echo 'converting markdown files to html...'
rm -f ./*.html
for file in ./src/*.md
do
    PREFIX=$(basename "$file" | cut -d. -f1)
    pandoc $file -T $PREFIX -V "pagetitle:$PREFIX" -V "title:$PREFIX" -w html5 -o "$PREFIX.html" --template ./templates/template.html
done
echo 'finished'

# build API documentation
echo 'building api documentation...'
cd ./src/docs
bundle install
bundle exec middleman build --clean --build-dir=../../docs
