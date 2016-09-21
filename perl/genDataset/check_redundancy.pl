#!/usr/bin/perl

$indir = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
$dbname = $ARGV[3];
if(@ARGV == 4){ $outdir = $indir; }
else{
	$outdir = $ARGV[4];
	if(!-e $outdir){ `mkdir $outdir`; }
}

$blast = "/home/chenxiao/blast/bin/blastpgp";
$db = "/home/chenxiao/database/".$dbname;

for($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $i).".fasta";
	$out = (join "/", $outdir, $i).".out";
	print "blasting...................\n";
	`$blast -e 0.001 -j 3 -h 0.001 -i $fasta -d $db -o $out`;
	print "done blast sequence$i\n";
}
