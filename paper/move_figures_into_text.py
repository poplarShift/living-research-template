#!/bin/python
import sys
if len(sys.argv)<=1:
    print('Specify a file name')
else:
    import re

    fname = sys.argv[1]

    with open(fname) as f:
        paper = f.read()

    def move_figure(paper, m):
        """
        Given string paper and a match that represents a markdown figure,
        move this figure to after the first time it is referenced.
        """
        tag = m.group(3).split(' ')[0]
        ref = tag.replace('#f', '@[Ff]')
        end_of_paragraph_pattern = f'({ref}.*\n)\n'
        end_of_paragraph = re.search(end_of_paragraph_pattern, paper).group()

        paper_wo_m = paper.replace(m.group(), '')
        return paper_wo_m.replace(end_of_paragraph, end_of_paragraph+m.group()+'\n\n')

    # loop through all figures
    figures = list(re.finditer(r'\!\[(.*)\]\((.*)\)\{(.*)\}', paper))
    for m in reversed(figures):
        paper = move_figure(paper, m)

    # Remove empty "figures" section
    paper = re.sub('# .*Figures.*\n+', '', paper)

    with open(fname, 'w') as f:
        f.write(paper)
