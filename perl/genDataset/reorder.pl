#!/usr/bin/perl

$indir = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
$type = $ARGV[3];
if(@ARGV == 4){ $outdir = $indir; }
else{
	$outdir = $ARGV[4];
	if(!-e $outdir){ `mkdir $outdir`; }
}
$pos = $start;
$flag = 0;
for($i = $start; $i <= $end; $i++){
	$fasta = (join "/", $indir, $i)."$type";
	$out = (join "/", $outdir, $pos)."$type";
	if(-e $fasta){
		if($flag == 1){
			if(@ARGV == 4){ `mv $fasta $out`; }
			else{ `cp $fasta $out`; }
		}
		$pos = $pos + 1;
	}else{
		$flag = 1;
	}
}
