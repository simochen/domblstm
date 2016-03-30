#!/usr/bin/perl

$type = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];

$dompro = "/home/simochen/Downloads/dompro1.0/bin/predict_dom.sh";
$dir = "/home/simochen/Downloads/dataset";

for ($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $dir, $type, $i).'.fasta';
	$out = (join "/", $dir, $type, $i).'.out';
	
	print "running dompro...........\n";
	`$dompro $fasta $out`;
	print "done predict sequence$i\n";
}
