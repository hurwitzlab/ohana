#!/usr/bin/env perl6
# ************ Record 1 ************
#      gene_name: HOT224_1_0770m_c1_1
#         cog_id: COG0186
#         source: NOG
#         evalue: 1.46100297172e-19
#         number: 72.6452789307
#           desc: One of the primary rRNA binding proteins, it binds
#                 specifically to the 5'-end of 16S ribosomal
# cog_categories: J#
#

use DBIish;

my @CREATE = (
    "drop table if exists gene",
    q:to/END/
    create table gene (
        gene_id integer primary key,
        gene_name text,
        cog_id text,
        source text,
        evalue numeric,
        desc text,
        cog_categories text
    )
    END
    ,
    "create unique index gene_name on gene (gene_name)"
);

sub MAIN (Str $file='eggnog-unique.txt') {
    my $fh     = open $file;
    my @flds   = $fh.get.split(/\t/);
    my @load   = @flds.grep({!/number/});
    my $dbh    = DBIish.connect("SQLite", :database<genes.db>);
    my $insert = sprintf('insert into gene (%s) values (%s)',
                @load.join(','), ('?' xx @load).join(','));
    my $rx     = rx/^ ('HOT' \d ** 3 '_' \d+ '_' \d+ 'm') '_'/;

    my %dbh;
    for $fh.lines.kv -> $i, $line {
        my %rec  = @flds Z=> $line.split(/\t/);
        my $name = %rec<gene_name>;
        if my $match = $name.match($rx) {
            printf "%3d: %s\n", $i, $name;
            my $sample = $match.caps[0].value;
            unless %dbh{ $sample }.defined {
                my $dbh = DBIish.connect("SQLite", :database($sample~".db"));
                for @CREATE -> $sql {
                    $dbh.do($sql);
                }
                %dbh{ $sample } = $dbh;
            }
            my $sth = %dbh{ $sample }.prepare($insert);
            $sth.execute(%rec{@load});
        }
    }

    put "Done.";
}
