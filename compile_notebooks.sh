#!/bin/bash

pushd nb
for file in `ls *.ipynb`
do
  fname=`echo $file | cut -d'.' -f 1`
  # run
  jupyter nbconvert --execute --to notebook --output=$fname $fname
  # render to html
  jupyter nbconvert --to html --output=../nb_html/$fname $fname
  # clear outputs
  jupyter nbconvert --ClearOutputPreprocessor.enabled=True --to notebook --output=$fname $fname
done
popd
