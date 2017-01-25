#!/usr/bin/env perl6

use File::Find;
use Test;

sub MAIN (Str :$dir=~$*CWD, Str :$md5="md5sum", Str :$ext='.md5') {
    my $rx = rx/$ext $/;
    for find(:dir($dir), :name($rx)) -> $md5-file {
        my $basename    = $md5-file.basename;
        my ($remote, $) = $md5-file.slurp.split(' ');
        my $local-file  = $basename.subst($rx, '');
        my $path        = $*SPEC.catfile(
                          $md5-file.dirname, $local-file);
        my ($local, $)  = run($md5, $path, :out)
                          .out.slurp-rest.split(' ');
        is $local, $remote, $md5-file;
    }

    done-testing();
}
