#!/usr/bin/perl

$indir = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
if(@ARGV == 3){ $outdir = $indir; }
else{ 
	$outdir = $ARGV[3];
	if(!-e $outdir){ `mkdir $outdir`; } 
}

$blast = "/home/chenxiao/blast/bin/blastpgp";
$db = "/home/mpiuser/ur90/uniref90";

for($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $i).'.fasta';
	$pssm = (join "/", $outdir, $i).'.pssm';

	print "blasting......................\n";
	`$blast -e 0.001 -j 3 -h 0.001 -i $fasta -d $db -Q $pssm`;
	print "done blast sequence",$i,"\n";
}
