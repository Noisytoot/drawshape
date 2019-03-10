#!/usr/bin/env perl
use strict;
use warnings;
use POSIX;
use feature 'say';

sub printBorderH {
    my ($size, $fh, $b) = @_;
    say "$b";
    for (my $i=0; $i < $b; $i++) {
	print $fh "0";
	for (my $i=0; $i < $size - 2; $i++) {
	    print $fh " 1";
	}
	print $fh " 0\n";
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
    print $fh "P1\n$size $size\n";
    
    # Prints the first line of 0s
    for (my $i=0; $i < $size - 1; $i++) {
        print $fh "0 ";
    }
    print $fh "0\n";
    
    printBorderH($size, $fh, $b);
    
    # Prints the main square body
    for (my $j=0; $j < $size - ($b * 2) - 2; $j++) {
        print $fh "0 " . borderV($b);
        for (my $i=0; $i < $size - ($b * 2) - 2; $i++) {
            print $fh "0 ";
        }
        print $fh borderV($b) . "0" . "\n";
    }
    
    printBorderH($size, $fh, $b);
    
    # Prints the last line
    for (my $i=0; $i < $size - 1; $i++) {
        print $fh "0 ";
    }
    print $fh "0\n";
    close $fh;
}
