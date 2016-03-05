#!/usr/bin/perl

use File::Basename;

$pssmfile = $ARGV[0];

@suffixlist = qw(.pssm .blast .fasta .dom);
#$dir = dirname($pssmfile);
$dir = "/home/simochen/Prog/genTest/multi";
$base = basename($pssmfile,@suffixlist);

$output = (join "/", $dir, $base).'_pssm.txt';
print $output,"\n";

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

