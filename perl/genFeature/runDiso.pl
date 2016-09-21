#!/usr/bin/perl

$indir = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
if(@ARGV == 3){ $outdir = $indir; }
else{ 
	$outdir = $ARGV[3];
	if(!-e $outdir){ `mkdir $outdir`; }
}

$diso = "/home/chenxiao/DISOPRED/run_disopred.pl";

if(@ARGV > 3){ `cp -r $indir $outdir`; }
for ($i = $start; $i <= $end; $i++){
	if(@ARGV == 3){ $fasta = (join "/", $indir, $i).'.fasta'; }
	else{ $fasta = (join "/", $outdir, $i).'.fasta'; }	

	print "predicting disorder...........\n";
	`$diso $fasta`;
	if(@ARGV > 3){ `rm $fasta`; }
	print "done predict sequence$i\n";
}
