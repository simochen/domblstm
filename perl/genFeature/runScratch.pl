#!/usr/bin/perl

$indir = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
if(@ARGV == 3){ $outdir = $indir; }
else{ 
	$outdir = $ARGV[3];
	if(!-e $outdir){ `mkdir $outdir`; }
}

$scratch = "/home/chenxiao/SCRATCH/bin/run_SCRATCH-1D_predictors.sh";
for($i = $start; $i <= $end; $i++){
	$base = "seg".$i;
	$fasta = (join "/", $indir, $base).'.fasta';
	$profix = (join "/", $outdir, $base);

	print "scratching...................\n";
	`$scratch $fasta $profix 1`;
	print "done scratch segment",$i,"\n";
}
