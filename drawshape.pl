#!/usr/bin/env perl

# Copyright © 2019 Noisytoot
# DrawShape: Draws shapes (currently only squares) to a Portable BitMap (PBM) file

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>

use strict;
use warnings;
use POSIX;
use feature 'say';

sub printBorderH {
    my ($size, $fh, $b) = @_;
    for (my $i=0; $i < $b; $i++) {
        print $fh "0";
        for (my $i=0; $i < $size - 2; $i++) {
            print $fh " 1";
        }
        say $fh " 0";
    }
}

sub help {
    say "DrawShape: Draws shapes (currently only squares) to a Portable BitMap (PBM) file\n";
    say "Help:";
    say "Size must be more than 10\n";
    say "How to draw a shape:";
    say "drawshape size filename\n";
    say "Example:";
    say "drawshape 60 shape0.pbm";
}

sub borderV {
    my $b = $_[0];
    return "1 " x $b;
}

if ($#ARGV == -1) {
    help();
} elsif ($#ARGV > 0) {
    my ($size, $filename) = @ARGV;
    if ($size < 10) {
        say "Size must be more than 10";
        exit 1;
    }
    my $b = ceil($size / 10);
    open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
    # Prints the PBM header
    say $fh "P1\n$size $size";
    
    # Prints the first line of 0s
    for (my $i=0; $i < $size - 1; $i++) {
        print $fh "0 ";
    }
    say $fh "0";
    
    printBorderH($size, $fh, $b);
    
    # Prints the main square body
    for (my $j=0; $j < $size - ($b * 2) - 2; $j++) {
        print $fh "0 " . borderV($b);
        for (my $i=0; $i < $size - ($b * 2) - 2; $i++) {
            print $fh "0 ";
        }
        say $fh borderV($b) . "0";
    }
    
    printBorderH($size, $fh, $b);
    
    # Prints the last line
    for (my $i=0; $i < $size - 1; $i++) {
        print $fh "0 ";
    }
    say $fh "0";
    close $fh;
}
