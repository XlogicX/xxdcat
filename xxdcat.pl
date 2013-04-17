use strict;
use warnings;

my $inputfile = $ARGV[0];
my $line;  		#Var for storing a line of hex output
my $address = 0;	#The Address ticker
my $countz;			#The number of characters in last line

$/ = undef;			#I often don't like newlines for raw stuff
open HEXSTUFF, "$inputfile";		#Get file
my $dataz = <HEXSTUFF>;				#Put it in a scalar

#While we have data
while ($dataz) {
	if ($dataz =~ /.{16}/ms) {	#if our next line is at least 16 bytes, use this
		$line = $&;				#put the 16 bytes in line variable
		printf '<%#.6x>', $address;	#print the address
		print "\t";					#tab
		print(join(' ', unpack('(H2)16', $line)));	#print the hex
		#print the ASCII
		if ($line =~ /\n/ || $line =~ /\t/ || $line =~ /\10/ || $line =~ /\x0d/) { #if there are newlins, tabs, backspaces, or vertical tabs
			my $lineb = $line;	#grab a destroyable line
			$lineb =~ s/\n/./g;	#convert newlines to a dot
			$lineb =~ s/\t/./g; #convert tabs to a dot
			$lineb =~ s/\10/./g;#convert backspaces to a dot
			$lineb =~ s/\x0d/./g; #convert viertical tabs to a dot
			print "\t\t$lineb\n";	#print the modified version
		} else {
			print "\t\t$line\n";	#otherwise, just print what you have, as it's fine
		}
		$dataz =~ s/.{16}//ms;		#shift out the first 16 bytes of file
		$address += 16;				#Increment address ticker by 16
	} else {						#this is our last line (less than 16 bytes)
		my @count = split ("", $dataz);	#make an array with each byte as an element of our last line
		$countz = @count;				#count the bytes (this will be for tab alignment)
		printf '<%#.6x>', $address;		#print the address
		print "\t";						#tab
		print(join(' ', unpack('(H2)16', $dataz)));		#print the hex
		my $tabs = 6.25 - ($countz / 4);	#Formula for how many tabs to print
		#print the tabs
		while ($tabs > 1) {
			print "\t";
			$tabs--;
		}
		#Same newline, tab, backspace destruction as the 16 byte routine
		if ($dataz =~ /\n/ || $dataz =~ /\t/ || $dataz =~ /\10/ || $dataz =~ /\x0d/) {
			my $datazb = $dataz;
			$datazb =~ s/\n/./g; $datazb =~ s/\t/./g; $datazb =~ s/\10/./g; $datazb =~ s/\x0d/./g;
			print "$datazb\n";
		} else {
			print "$dataz\n";
		}
		$dataz = undef;	#destroy our data so we don't infinitely repeat this else
	}
}
