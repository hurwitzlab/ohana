#!/usr/bin/env python

import sqlite3
import re
import sys
import os

create = [
    "drop table if exists gene",
    """
    create table gene (
        gene_id integer primary key,
        gene_name text,
        cog_id text,
        source text,
        evalue numeric,
        desc text,
        cog_categories text
    )""",
    "create unique index gene_name on gene (gene_name)"
]

if len(sys.argv) != 2:
    print('Usage: {} file'.format(sys.argv[0]))
    exit(1)

file   = sys.argv[1]
print('Processing file ' + file)
eggnog = open(file, 'rt')
header = eggnog.readline().rstrip().split('\t')
fields = list(filter(lambda x: x != 'number', header))
insert = 'insert into gene ({}) values ({})'.format(
         ','.join(fields), ','.join(['?'] * len(fields)))

base, ext = os.path.splitext(file)
dbh = sqlite3.connect(base + '.db')
for statement in create:
    dbh.execute(statement)
dbh.commit()

i = 0
for line in eggnog:
    data = line.rstrip().split('\t')
    dbh.execute(insert, data)
    i += 1

dbh.commit()

print('Done, processed ' + str(i))
