#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$origin = $ARGV[0];
$out = $ARGV[1];

open(ori, "<$origin");
@ori = <ori>;
close(ori);

open(out, ">$out");

$line = shift(@ori);
while ($line ne ""){
	$seqname = substr($line, 0, 6);
	print out $seqname."\n";
	$res = "";
	$line = shift(@ori);
	chomp($line);
	while($line ne ""){
		$res = $res.$line;
		$line = shift(@ori);
		chomp($line);
	}
	print out $res."\n";
	shift(@ori);
	$line = shift(@ori);
}

close(out);	
