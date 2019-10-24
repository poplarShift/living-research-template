#!/bin/bash

cslfile='elementa.csl'
articlefile='paper'
bib_full='bibliographyfull.bib'

pushd paper # ./paper

# create static version from master
# here, we used CriticMarkup to use a syntax that's already used by at least someone
# the first option refers to the static version (e.g. png figures), the second to the interactive one (html figures)
perl -0777 -pe 's/{~~(.*)~>(.*)~~}/\1/gs' $articlefile.md > ${articlefile}_static.md
perl -0777 -pe 's/{~~(.*)~>(.*)~~}/\2/gs' $articlefile.md > ${articlefile}_interactive.md
# include height of each HTML element in markdown
# should find a better solution than Selenium+PhantomJS (deprecation warning)
python add_html_heights_to_interactive_markdown.py ${articlefile}_interactive.md


# compile static paper
pandoc --bibliography $bib_full --filter pandoc-crossref --filter pandoc-citeproc --csl $cslfile --mathjax -s  --self-contained --resource-path=.:../nb_fig/:../fig -o ${articlefile}_static.html ${articlefile}_static.md

# compile interactive paper
pandoc --bibliography $bib_full --filter pandoc-crossref --filter pandoc-citeproc --csl $cslfile  --self-contained --resource-path=.:../nb_fig/:../fig -o ${articlefile}_interactive.html ${articlefile}_interactive.md

popd # ./
