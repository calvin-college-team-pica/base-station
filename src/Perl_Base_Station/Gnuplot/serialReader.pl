#! /usr/bin/perl -w

##########################################################################
# Author: Kendrick Wiersma
#   Date: 6 May 2011
#  Email: Kendrick.G.Wiersma@gmail.com
#
# For Senior Design 2011 Team 01 Team PICA. This simulates our basestation
#   functionality, within a reasonable shadow of a doubt :)
###########################################################################
use Device::SerialPort;
use Getopt::Long;
use Switch;

use strict;

my $printer=0;
my $help;

GetOptions( "printer=i" => \$printer,
            "help"      => \$help);   # parse command line option for which
if($help || $printer > 4 || $printer < 1){&usage}; # ensure valid comamnds

# Setup STDOUT to auto-flush
# Note: this disables the default buffered behaviour of stdout
select((select(STDOUT), $| = 1)[0]);

my $serialPort = Device::SerialPort->new("/dev/ttyS0") or die "Can't get the serial device\n"; # grab the serial port
$serialPort->databits(8);       # Set the number of data bits
$serialPort->baudrate(115200);  # Set the baudrate
$serialPort->parity("none");    # Select the parity
$serialPort->stopbits(1);       # Select the number of stopbits

my $charBuffer;                 # Buffer to hold our input

print "I'm about to start listening on the serial port";
while(1) {
    my $char = $serialPort->lookfor(); # Wait for a character (blocks)
    if($char){
#	print $char . "\n";
	my @array = split(/ /, $char);
	print $array[$printer-1] . "\n";
#	print "Got char: " . $char . "\n";
#	if($char eq 0xD) {                   # Start of Transmission (STX)
#	    $charBuffer = "";              # start by nuking the character buffer
#	} elsif ($char eq 0xA) {             # End of Transmission (EOT)
	#    my @array = split('/ /', $char);
	#    print $array[$printer-1];      # Here we want to print the character buffer
#	  print $charBuffer;
#	} else {                
#	    print "Accumulated: " . $char . "\n";
#	    $charBuffer .= $char;       # Otherwise just accumulate
#	    print $charBuffer . "\n";
#	    $char = "";
#	}
    }
}

###########################################################################
# Function: Usage
#     Displays some helpful usage information :) 
#     Because seriously, who doesn't give usage info...oh wait...
###########################################################################
sub usage {
    print <<ENDOFHELP;
    This script is intended to be piped with the driveGnuplot script
    Commandline options include:
       -printer  Sets which power to print valid options are 1, 2, 3, 4
           1 - Prints channel 1 Power
	   2 - Prints channel 2 Power
	   3 - Prints channel 3 Power
	   4 - Prints total power
	-help  Displays this help message
ENDOFHELP
die;
}
