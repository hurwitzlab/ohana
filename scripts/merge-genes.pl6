#!/usr/bin/env perl6

my @flds = <gene_name cog_id source evalue number type value>;
my @out  = <gene_name cog_id source evalue number desc cog_categories>;

sub MAIN (Str $file!) {
    put @out.join("\t");
    my %last = gene_name => "";;
    for $file.IO.lines.kv -> $i, $line {
        my %rec  = @flds Z=> $line.split(/\t/);
        next unless %rec<type>;
        my $type = %rec<type> eq 'Description' ?? 'desc' !! 'cog_categories';
        %rec{ $type } = %rec<value>;

        if %rec<gene_name> eq %last<gene_name> {
            my %merge = %( %rec, %last );
            put join "\t", %merge{ @out };
        }

        %last = %rec;
    }

    put "Done.";
}
