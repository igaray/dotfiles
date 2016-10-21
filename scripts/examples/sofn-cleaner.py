#!/usr/bin/python
from BeautifulSoup import BeautifulSoup
import sys
import re

if (len(sys.argv) != 3):
    print("Use: parser.py input output")
    print(sys.argv[0])
    print(sys.argv[1])
    print(sys.argv[2])
else:
    input  = open(sys.argv[1], 'r')
    output = open(sys.argv[2], 'w')
    string = input.read()
    soup   = BeautifulSoup(''.join(string))

    trs = soup.findAll(name = 'tr')
    for tr in trs:
        del(tr['valign'])

    tds = soup.findAll(name = 'td')
    for td in tds:
        del(td['align'])
        del(td['border'])
        del(td['class'])
        del(td['height'])
        del(td['width'])
        del(td['valign'])

    tables = soup.findAll(name = 'table')
    for table in tables:
        del(table['border'])
        del(table['cellpadding'])
        del(table['cellspacing'])
        del(table['class'])
        del(table['height'])
        del(table['valign'])
        del(table['width'])

    atags = soup.findAll(name = 'a')
    for atag in atags:
        atag.extract()

    imgtags = soup.findAll(name = 'img')
    for imgtag in imgtags:
        imgtag.extract()

    output.write(soup.prettify())
    input.close()
    output.close()

