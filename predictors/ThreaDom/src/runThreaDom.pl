#!/usr/bin/perl

$type = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];

$iTasser = "/home/chenxiao/threadom/runLOMETS4ThreaDom.pl";
$threadom = "/home/chenxiao/threadom/ThreaDom.pl";
$detec = "/home/chenxiao/threadom/detectdcd.pl";

$indir = "/home/chenxiao/dataset";
$libdir = "/home/chenxiao/I-TASSER2.1";
$predir = "/home/chenxiao/dataset/ThreaDom";
$javadir = "/usr/share/java";

for ($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $type, $i).'.fasta';
	$datadir = (join "/", $predir, $type, $i);
	
	open(fasta,"<$fasta");
	$line = <fasta>;
	close(fasta);

	$seqname = substr($line, 1, 5);

	print "make dir $datadir.\n";
	`mkdir $datadir`;
	print "copy $fasta to $datadir/seq.fasta\n";
	`cp $fasta $datadir/seq.fasta`;

	print "running I-TASSER.........\n";
	`$iTasser -libdir $libdir -seqname $seqname -datadir $datadir -javadir $javadir`;
	print "running ThreaDom.........\n";
	`$threadom -seqname $seqname -datadir $datadir`;
	print "running detectdcd.........\n";
	`$detec -seqname $seqname -datadir $datadir`;
	print "done predict sequence$i\n";
}
