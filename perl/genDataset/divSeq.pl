#!/usr/bin/perl

#divide sequence file to individual files
#USAGE: divSeq.pl $seqfile $dir

$seqfile = $ARGV[0];
$dir = $ARGV[1];

open(seq, "<$seqfile");
@lines = <seq>;
close(seq);


$domNum = 1;
while ($line = shift(@lines)){
	$outFasta = (join "/", $dir, $domNum).'.fasta';
	open(fasta, ">$outFasta");
#line1: sequence name
	print fasta $line;
#line2: sequence
	$line = shift(@lines);
	chomp($line);
	print fasta $line;

	close(fasta);
	$domNum++;
}
