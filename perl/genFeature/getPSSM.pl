#!/usr/bin/perl

use File::Basename;

$pssmfile = $ARGV[0];
$dir = $ARGV[1];

@suffixlist = qw(.pssm .blast .fasta .dom);
#$dir = dirname($pssmfile);
$base = basename($pssmfile,@suffixlist);

$output = (join "/", $dir, $base).'_pssm.txt';

open(pssm, "<$pssmfile");
@lines = <pssm>;
close(pssm);

open(out, ">$output");

shift(@lines);
shift(@lines);
shift(@lines);

$line = shift(@lines);
chomp($line);
while ($line){	
	$pos = index($line, "   ", 10);
	$check = substr($line, $pos-3, 3);
	if($check eq "100"){ $pos -= 5; }
	$data = substr($line, 10, $pos-10);
	print out "$data\n";
	$line = shift(@lines);
	chomp($line);
}

close(out);

