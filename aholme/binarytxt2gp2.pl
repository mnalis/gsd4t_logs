#!/usr/bin/perl -w

use strict;
use autodie;
use feature 'say';

# from http://www.perlmonks.org/?node_id=644225
sub b2h {
    my $num   = shift;
    my $WIDTH = 8;
    my $index = length($num) - $WIDTH;
    my $hex = '';
    do {
        my $width = $WIDTH;
        if ($index < 0) {
            $width += $index;
            $index = 0;
        }
        my $cut_string = substr($num, $index, $width);
        $hex = sprintf('%02X', oct("0b$cut_string")) . ' ' .$hex;
        $index -= $WIDTH;
    } while ($index > (-1 * $WIDTH));
    return $hex;
}


# encapsulate in fake raw4t headers
open my $in, '<', '50bps.binary.txt';
my $count=0;
while (<$in>) {
    chomp;
    my $hex = b2h($_);
    printf "00/00/0008 00:00:%02d.%03d (0) 85 01 01 00 00 00 00 00 00 00 00 $hex\n", 0, $count++;
}
