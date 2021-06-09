#!/bin/bash

export cslfile='elementa.csl' # citation style file
export bib='bibliography.bib' # bibliography for just this article
export bib_full='bibliographyfull.bib' # master bibliography, could be only a symlink

cd paper # ./paper

export file='paper'

./parse_file.sh

# preferably use full bib file, but if unavailable (e.g. in exported docker or
# public repo) then use the reduced file (exported with bibexport)
if [ -f $bib_full ]; then
  bib=$bib_full
fi

echo Using bibfile: $bib

# --- compile Frontiers draft
# -docx
pandoc --bibliography $bib --filter pandoc-crossref --filter pandoc-citeproc --csl $cslfile --reference-doc reference.docx --mathjax -o ${file}.docx ${file}_static.md

# now that Frontiers draft is done, move figures up into text
python move_figures_into_text.py ${file}_static.md
# --- static paper
# -html
pandoc --bibliography $bib --filter pandoc-crossref --filter pandoc-citeproc --csl $cslfile --self-contained --resource-path=.:../nb_fig/:../fig --mathjax -o ${file}_static.html ${file}_static.md

# make version with tracked changes
./diff.sh

# clean up
rm ${file}_static.md

cd .. # ./
