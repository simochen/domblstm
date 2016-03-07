#!/usr/bin/perl

use File::Basename;

$ssfile = $ARGV[0];
$outdir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$indir = dirname($ssfile);
$base = basename($ssfile,@suffixlist);

open(ss, "<$ssfile");
@lines = <ss>;
close(ss);

$segNum = substr($base,3,length($base)-3);
$i = 1;
while ($line = shift(@lines)){
	$cnt = ($segNum - 1) * 10 + $i;
	$outSS = (join "/", $outdir, $cnt).'_ss.txt';
	open(outSS, ">$outSS");
#line1: sequence name	
	
#line2: SS (H:helix, E: strand, C: coil)
	$line = shift(@lines);
	chomp($line);
	for($k = 0; $k < length($line); $k++){
		$ss = substr($line, $k, 1);
		if ($ss eq "H"){ print outSS "1 0 0\n"; }
		elsif ($ss eq "E"){ print outSS "0 1 0\n"; }
		else{ print outSS "0 0 1\n"; }
	}
	close(outSS);

	$i++;
}
