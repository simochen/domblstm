#!/usr/bin/perl

use File::Basename;

$safile = $ARGV[0];
$dir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$dir = dirname($seqfile);
$base = basename($safile,@suffixlist);

open(sa, "<$safile");
@lines = <sa>;
close(sa);

$outSA = (join "/", $dir, $domNum).'.sa';
open(sa, ">$outSA");

while ($line = shift(@lines)){
#line1: sequence name	

#line2: SA (e:exposed, b:buried at 25% threshold)
	$line = shift(@lines);
    chomp($line);
	for($i = 0; $i < length($line); $i++){
		$sa = substr($line, $i, 1);
		if ($sa eq "e"){ print sa "1 "; }
		else{ print sa "0 "; }
	}
	print sa "\n";
}

close(sa);

