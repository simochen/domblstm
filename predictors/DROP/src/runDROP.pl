#!/usr/bin/perl

$type = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];

$DROP = "/home/simochen/Prog/DROP/runDROP";
$indir = "/home/simochen/Prog/DROP/fasta";
$outdir = "/home/simochen/Prog/DROP/output";

for ($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $type, $i).'.fasta';
	
	print "running DROP...........\n";
	`$DROP $fasta $outdir`;
	print "done predict sequence$i\n";
}
