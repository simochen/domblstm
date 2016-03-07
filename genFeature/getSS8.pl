#!/usr/bin/perl

use File::Basename;

$ss8file = $ARGV[0];
$outdir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$indir = dirname($ss8file);
$base = basename($ss8file,@suffixlist);

open(ss8, "<$ss8file");
@lines = <ss8>;
close(ss8);

$segNum = substr($base,3,length($base)-3);
$i = 1;
while ($line = shift(@lines)){
	$cnt = ($segNum - 1) * 10 + $i;
	$outSS8 = (join "/", $outdir, $cnt).'_ss8.txt';
	open(outSS8, ">$outSS8");
#line1: sequence name	
	
#line2: SS8 (H:helix, E: strand, C: coil)
	$line = shift(@lines);
	chomp($line);
	for($k = 0; $k < length($line); $k++){
		$ss8 = substr($line, $k, 1);
		if ($ss8 eq "G"){ print outSS8 "0 0 0\n"; }
		elsif ($ss8 eq "H"){ print outSS8 "0 0 1\n"; }
		elsif ($ss8 eq "I"){ print outSS8 "0 1 0\n"; }
		elsif ($ss8 eq "T"){ print outSS8 "0 1 1\n"; }
		elsif ($ss8 eq "E"){ print outSS8 "1 0 0\n"; }
		elsif ($ss8 eq "B"){ print outSS8 "1 0 1\n"; }
		elsif ($ss8 eq "S"){ print outSS8 "1 1 0\n"; }
		else{ print outSS8 "1 1 1\n"; }
	}
	close(outSS8);

	$i++;
}
