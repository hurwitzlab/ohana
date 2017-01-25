#!/usr/bin/env python

import re

eggnog  = open('eggnog-unique.txt', 'rt')
header  = eggnog.readline().rstrip().split('\t')
fields  = list(filter(lambda x: x != 'number', header))
fh      = dict()
took    = 0
skipped = 0

for line in eggnog:
    data  = dict(zip(header, line.rstrip().split('\t')))
    match = re.match('^(HOT\d{3}_(?:\d*_)?\d*m)', data['gene_name'])

    if not match:
        print('Cannot match ' + data['gene_name'])
        skipped += 1
        continue

    sample = match.group(0)

    if not sample in fh:
        fh[sample] = open(sample + '.txt', 'wt')
        fh[sample].write('\t'.join(fields) + '\n')

    fh[sample].write('\t'.join([data[x] for x in fields]) + '\n')
    took += 1

print('Done, took {}, skipped {}'.format(took, skipped))
