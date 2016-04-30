#!/usr/bin/perl

$type = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];

$iTasser = "/home/chenxiao/threadom/runLOMETS4ThreaDom.pl";

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
	
	if(!-e $datadir){
		print "make dir $datadir\n";
		`mkdir $datadir`;
	}else{
		print "$datadir exist\n";
	}
	if(!-e "$datadir/seq.fasta"){
		print "copy $fasta to $datadir/seq.fasta\n";
		`cp $fasta $datadir/seq.fasta`;
	}else{
		print "$datadir/seq.fasta exist\n";
	}
	print "running I-TASSER.........\n";
	$time = `date`;
	print "starting time: $time\n";
	`$iTasser -libdir $libdir -seqname $seqname -datadir $datadir -javadir $javadir`;
	print "done process sequence$i\n";
	$time = `date`;
	print "ending time: $time\n";
}
