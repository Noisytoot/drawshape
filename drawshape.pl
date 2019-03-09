#!/usr/bin/env perl
use strict;
use warnings;
use POSIX;
sub PrintBorderH {
    my ($size, $fh) = @_;
    my $b = ceil($size / 10);
    print "$b\n";
    print $fh "0";
    for (my $i=1; $i <= $size - 2; $i++) {
        print $fh " 1";
    }
    print $fh " 0\n";
}

sub help {
    print "DrawShape: Draws shapes (currently only squares) to a Portable BitMap (PBM) file\n\n";
    print "Options:\n";
    print "Help: no arguments (just drawshape)\n\n";
    print "How to draw a shape:\n";
    print "drawshape size filename\n";
    print "Example:\n";
    print "drawshape 60 shape0.pbm\n";
}

if ($#ARGV == -1) {
    help();
} elsif ($#ARGV > 0) {# elsif = else if
    my ($size, $filename) = @ARGV;
    open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
    # Prints the PBM header
    print $fh "P1\n$size $size\n";
    
    # Prints the first line of 0s
    for (my $i=0; $i < $size - 1; $i++) {
        print $fh "0 ";
    }
    print $fh "0\n";
    
    PrintBorderH($size, $fh);
    
    # Prins the main square body
    for (my $j=0; $j <= $size - 5; $j++) {
        print $fh "0 1";
        for (my $i=1; $i <= $size - 4; $i++) {
            print $fh " 0";
        }
        print $fh " 1 0\n";
    }
    
    PrintBorderH($size, $fh);
    
    # Prints the last line
    for (my $i=0; $i < $size - 1; $i++) {
        print $fh "0 ";
    }
    print $fh "0\n";
    close $fh;
}
