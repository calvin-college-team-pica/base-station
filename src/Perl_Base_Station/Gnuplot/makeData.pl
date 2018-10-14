#! /usr/bin/perl -w

use strict;

# First, set the standard output to auto-flush 
select((select(STDOUT), $| = 1)[0]);

my $number = 117;
my $otherNum = 20;

my $runs = 50;

while( 1 ){
    print $runs % 4 . "\n";
    if( $runs % 4 == 0 ){
	my $rand = int(rand(100));
	print $number-$rand ."\n";
#	print $otherNum-$rand . "\n";
    }
    print $number ."\n";
#    print $otherNum . "\n";
    $runs -= 1;
    if( $runs == 0 ){
	$runs=50;
    }
system("sleep 0.02") == 0 or last; 
}
