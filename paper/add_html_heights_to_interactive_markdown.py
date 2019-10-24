#!/bin/python
import sys
if len(sys.argv)<=1:
    print('Specify a file name')
else:
    from selenium import webdriver
    driver = webdriver.PhantomJS()

    import re, os
    fname = sys.argv[1]

    with open(fname) as f:
        paper = f.read()

    def get_max_html_height(fname):
        driver.get('file://'+os.getcwd()+'/'+fname)
        return max([e.size['height'] for e in driver.find_elements_by_class_name('bk')])

    def add_height_to_markdown(m):
        return '![' + m.group(1) + '](' + m.group(2) + '){' + m.group(3) + ' width=100% height=' + str(get_max_html_height(m.group(2))) + '}'

    paper_sub = re.sub(r'\!\[(.*)\]\((.*)\)\{(.*)\}', add_height_to_markdown, paper)

    with open(fname, 'w') as f:
        f.write(paper_sub)
