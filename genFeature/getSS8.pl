#!/usr/bin/perl

use File::Basename;

$ss8file = $ARGV[0];
$dir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$dir = dirname($seqfile);
$base = basename($ss8file,@suffixlist);

open(ss8, "<$ss8file");
@lines = <ss8>;
close(ss8);

$domNum = 1;
while ($line = shift(@lines)){
	$outSS8 = (join "/", $dir, $domNum).'_ss8.txt';
	open(outSS8, ">$outSS8");
#line1: sequence name	
	
#line2: SS8 (H:helix, E: strand, C: coil)
	$line = shift(@lines);
	chomp($line);
	for($i = 0; $i < length($line); $i++){
		$ss8 = substr($line, $i, 1);
		if ($ss8 eq "G"){ print outSS8 "1 0 0 0 0 0 0 0\n"; }
		elsif ($ss8 eq "H"){ print outSS8 "0 1 0 0 0 0 0 0\n"; }
		elsif ($ss8 eq "I"){ print outSS8 "0 0 1 0 0 0 0 0\n"; }
		elsif ($ss8 eq "T"){ print outSS8 "0 0 0 1 0 0 0 0\n"; }
		elsif ($ss8 eq "E"){ print outSS8 "0 0 0 0 1 0 0 0\n"; }
		elsif ($ss8 eq "B"){ print outSS8 "0 0 0 0 0 1 0 0\n"; }
		elsif ($ss8 eq "S"){ print outSS8 "0 0 0 0 0 0 1 0\n"; }
		else{ print outSS8 "0 0 0 0 0 0 0 1\n"; }
	}
	close(outSS8);

	$domNum++;
}
