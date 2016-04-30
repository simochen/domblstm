#!/usr/bin/perl

$type = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];

$predir = "/home/chenxiao/dataset/ThreaDom";
$outfile = (join "/", $predir, $type)."_res.txt";

for ($i = $start; $i <= $end; $i++){
	$datadir = join "/", $predir, $type, $i;
	$seq = join "/", $datadir, "seq.txt";
	
	if (!-e $seq){
		print "sequence$i not exist.\n";
		exit();
	}
	
	open(SEQ, "<$seq");
	$line = <SEQ>;
	close(SEQ);

	$seqname = substr($line, 1, 5);
	$result = (join "/", $datadir, $seqname).".result";
	
	if (!-e $result){
		print "sequence$i predict result not exist.\n";
		exit();
	}
	
	open(RES, "<$result");
	$line = <RES>;
	close(RES);
	
	open(OUT, ">>$outfile");
	print OUT "$i\n";
	print OUT $line;
	close(OUT);
}