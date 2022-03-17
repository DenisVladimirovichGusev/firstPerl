#!/usr/bin/perl 

my $file = 'events.log'; 
my $date = ''; 
my $minute = ''; 
my $state = ''; 
my $okCounter = 0; 
my $nokCounter = 0; 

open FILE, '<', $file or die $!; 

while (<FILE>) { 
    if ( /\[(.{10}?)(\s+?)(\S{5}?)(.*)\](\s+?)(\S+?)$/ ) { 
        if ( $date eq $1 ) {
			if ( $minute eq $3 ) {
				if ( $6 eq 'OK' ) {
					$okCounter += 1;
				} else {
					$nokCounter += 1;
				}
			} else {
				print "$date/$minute/OK:$okCounter\n";
				print "$date/$minute/NOK:$nokCounter\n";
				$minute = $3;
				if ( $6 eq 'OK' ) {
					$okCounter = 1;
					$nokCounter = 0;
				} else {
					$nokCounter = 1;
					$okCounter = 0;
				}
			}
		} else {
			print "$date/$minute/OK:$okCounter\n";
			print "$date/$minute/NOK:$nokCounter\n";
			$date = $1;
			$minute = $3;
		    if ( $6 eq 'OK' ) {
				$okCounter = 1;
				$nokCounter = 0;
			} else {
				$nokCounter = 1;
				$okCounter = 0;
			}
		}
	}
}
print "$date/$minute/OK:$okCounter\n"; 
print "$date/$minute/NOK:$nokCounter\n"; 

 