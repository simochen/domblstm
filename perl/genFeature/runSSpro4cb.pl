#!/usr/bin/perl

#USAGE: runDompro.pl domtype[multi,single] start end

$domtype = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
$indir = "/home/simochen/Prog/dataset/".$domtype;
$outdir = "/home/simochen/Prog/dataset/dompro/".$domtype;

$sspro = "/home/simochen/Prog/sspro4/bin/predict";
$runssa = $sspro."_ss_sa.sh";
for($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $i).'.fasta';
	$ssafile = (join "/", $outdir, $i).".ssa";
	$align = $ssafile."align";

	`$runssa $fasta $ssafile`;
	`rm $align`;
	print "done predict sequence",$i,"\n";
}
