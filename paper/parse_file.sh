#!/bin/bash

# here, we used CriticMarkup to use a syntax that's already used by at least someone
# First insert newlines after closing brackets so the regex matching becomes easier (otherwise, lumps together all bracket expressions per line).
perl -0777 -pe 's/~~}/~~}\n/g' $file.md > ${file}_tmp.md
# the first option refers to the static version (e.g. png figures), the second to the interactive one (html figures)
perl -0777 -pe 's/{~~(.*)~>(.*)~~}\n/\1/g' ${file}_tmp.md > ${file}_static.md
perl -0777 -pe 's/{~~(.*)~>(.*)~~}\n/\2/g' ${file}_tmp.md > ${file}_interactive.md
rm ${file}_tmp.md
