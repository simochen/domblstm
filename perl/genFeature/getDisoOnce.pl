#!/usr/bin/perl

use File::Basename;

$disofile = $ARGV[0];
$dir = $ARGV[1];

@suffixlist = qw(.diso .blast .fasta .dom);
#$dir = dirname($disofile);
$base = basename($disofile,@suffixlist);

$output = (join "/", $dir, $base).'_diso.txt';

open(diso, "<$disofile");
@lines = <diso>;
close(diso);

open(out, ">$output");

shift(@lines);
shift(@lines);
shift(@lines);

while ($line = shift(@lines)){	
	$data = substr($line, 10, 4);
	print out "$data\n";
}

close(out);

