#!/usr/bin/perl -w

use strict;
use autodie;
use feature 'say';

# from http://www.perlmonks.org/?node_id=644225
sub b2h {
    my $num   = shift;
    my $WIDTH = 32;
    my $index = length($num) - $WIDTH;
    my $hex = '';
    do {
        my $width = $WIDTH;
        if ($index < 0) {
            $width += $index;
            $index = 0;
        }
        my $cut_string = substr($num, $index, $width);
        $hex = sprintf('%X', oct("0b$cut_string")) . $hex;
        $index -= $WIDTH;
    } while ($index > (-1 * $WIDTH));
    return $hex;
}


open my $in, '<', '50bps.binary.txt';
while (<$in>) {
    chomp;
    say "$_ = " . b2h($_); 
}