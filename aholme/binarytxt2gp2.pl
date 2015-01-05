#!/usr/bin/perl -w

use strict;
use autodie;
use feature 'say';

sub b2h {
    my $bin = shift;
    my $hex = '';
    while ($bin) {
        my $cut = substr($bin,0,30,'');	# gps uses 30bit words, not 32bit, so we pad MSB with '00'
        #say "cut=$cut";
        $hex .= sprintf('%08X', oct("0b$cut"));
    }
    return $hex;
}


# encapsulate in fake raw4t headers
open my $in, '<', '50bps.binary.txt';
my $count=0;
while (<$in>) {
    chomp;
    my $hex = b2h($_);
    $hex =~ s/(..)/$1 /g;
    printf "00/00/0008 00:00:%02d.%03d (0) 85 01 01 00 FF 00 00 00 00 00 FF $hex\n", 0, $count++;
}
