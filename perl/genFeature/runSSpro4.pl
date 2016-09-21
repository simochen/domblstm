#!/usr/bin/perl

#USAGE: runDompro.pl domtype[multi,single] start end

$domtype = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
$indir = "/home/simochen/Prog/dataset/".$domtype;
$outdir = "/home/simochen/Prog/dataset/dompro/".$domtype;

$sspro = "/home/simochen/Prog/sspro4/bin/predict";
$runss = $sspro."_ssa.sh";
$runsa = $sspro."_acc.sh";
for($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $i).'.fasta';
	$ssfile = (join "/", $outdir, $i).".ss";
	$safile = (join "/", $outdir, $i).".acc";

	`$runss $fasta $ssfile`;
	`$runsa $fasta $safile`;
	print "done predict sequence",$i,"\n";
}
