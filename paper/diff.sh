#!/bin/bash

tmpdir=_tmp_manuscript_diff

# set only if not already defined
: "${bib:=bibliographyfull.bib}"

git clone -b v1.0 .. $tmpdir

# parse papers both in old and new versions

# old
cd $tmpdir/paper
old=$tmpdir/paper/${file}.md
cd ../..
# new
new=${file}.md

tracked=${file}_trackchanges

pandiff $old $new -o $tracked.html --bibliography $bib --filter pandoc-crossref  --filter pandoc-citeproc #--reference-doc $refdoc --csl $cslfile --mathjax
# these additional options need pandiff install from https://github.com/poplarShift/pandiff/tree/options

# append stylesheet
echo '
<style>
del {
  color: #b31d28;
  background-color: #ffeef0;
  text-decoration: line-through;
}
ins {
  color: #22863a;
  background-color: #f0fff4;
  text-decoration: underline;
}
img {
  max-width: 100%;
  min-width: 60%;
}
</style>
' >> $tracked.html

rm -rf $tmpdir
