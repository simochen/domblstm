#!/usr/bin/perl

$dir = $ARGV[0];
$scratch = "/home/chenxiao/SCRATCH/bin/run_SCRATCH-1D_predictors.sh";
for($i = 1; $i <= 5; $i++){
	$base = "seg".$i;
	$fasta = (join "/", $dir, $base).'.fasta';
	$profix = (join "/", $dir, $base);

	print "scratching...................\n";
	`$scratch $fasta $profix 1`;
	print "done scratch segment",$i,"\n";
}
