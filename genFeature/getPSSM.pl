#!/usr/bin/perl

# USAGE: getPSSM.pl pssmfile dir

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
	$data = substr($line, 10, 59);
	print out "$data\n";
	$line = shift(@lines);
	chomp($line);
}

close(out);
