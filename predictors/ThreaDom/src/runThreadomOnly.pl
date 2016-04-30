#!/usr/bin/perl

$type = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];

$threadom = "/home/chenxiao/threadom/ThreaDom.pl";
$detec = "/home/chenxiao/threadom/detectdcd.pl";

$indir = "/home/chenxiao/dataset";
$predir = "/home/chenxiao/dataset/ThreaDom";

for ($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $type, $i).'.fasta';
	$datadir = (join "/", $predir, $type, $i);
	
	open(fasta,"<$fasta");
	$line = <fasta>;
	close(fasta);

	$seqname = substr($line, 1, 5);

	print "running ThreaDom.........\n";
	`$threadom -seqname $seqname -datadir $datadir`;
	print "running detectdcd.........\n";
	`$detec -seqname $seqname -datadir $datadir`;
	print "done predict sequence$i\n";
}
