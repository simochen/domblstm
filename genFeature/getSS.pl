#!/usr/bin/perl

use File::Basename;

$ssfile = $ARGV[0];
$dir = $ARGV[1];

@suffixlist = qw(.ss .pssm .blast .fasta .dom);
#$dir = dirname($seqfile);
$base = basename($ssfile,@suffixlist);

open(ss, "<$ssfile");
@lines = <ss>;
close(ss);

$domNum = 1;
while ($line = shift(@lines)){
	$outSS = (join "/", $dir, $domNum).'_ss.txt';
	open(outSS, ">$outSS");
#line1: sequence name	
	
#line2: SS (H:helix, E: strand, C: coil)
	$line = shift(@lines);
	chomp($line);
	for($i = 0; $i < length($line); $i++){
		$ss = substr($line, $i, 1);
		if ($ss eq "H"){ print outSS "1 0 0\n"; }
		elsif ($ss eq "E"){ print outSS "0 1 0\n"; }
		else{ print outSS "0 0 1\n"; }
	}
	close(outSS);

	$domNum++;
}
