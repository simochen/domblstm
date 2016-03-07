#!/usr/bin/perl

use File::Basename;

$safile = $ARGV[0];
$outdir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$indir = dirname($safile);
$base = basename($safile,@suffixlist);

open(sa, "<$safile");
@lines = <sa>;
close(sa);

$segNum = substr($base,3,length($base)-3);
$i = 1;
while ($line = shift(@lines)){
	$cnt = ($segNum - 1) * 10 + $i;
	$outSA = (join "/", $outdir, $cnt).'_acc.txt';
	open(outSA, ">$outSA");
#line1: sequence name	

#line2: SA (e:exposed, b:buried at 25% threshold)
	$line = shift(@lines);
    chomp($line);
	for($k = 0; $k < length($line); $k++){
		$sa = substr($line, $k, 1);
		if ($sa eq "e"){ print outSA "1\n"; }
		else{ print outSA "0\n"; }
	}
	close(outSA);

	$i++;
}
