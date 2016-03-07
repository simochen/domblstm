#!/usr/bin/perl

# generate SS and SA features
# by calling getSS, getSA, etc.
# USAGE: getSSA.pl sstype satype segNum indir (outdir)

use File::Basename;

$sstype = $ARGV[0];
$satype = $ARGV[1];
$segNum = $ARGV[2];
$indir = $ARGV[3];
if(@ARGV == 4){ $outdir = $indir; }
else{ $outdir = $ARGV[4]; }

#@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);

#$rundir = "/home/chenxiao/getFeature/";
$rundir = "./";
# run file profix
$runpro = $rundir."get";
$runcb = $rundir."combineSSA.pl";
for($i = 1; $i <= $segNum; $i++){
	$base = "seg".$i;
	# segment profix
	$profix = join "/", $indir, $base;
	$ssfile = join ".", $profix, $sstype;
	$safile = join ".", $profix, $satype;
	$runss = $runpro.uc($sstype).".pl";
	$runsa = $runpro.uc($satype).".pl";
	`$runss $ssfile $outdir`;
	`$runsa $safile $outdir`;

	for($j = 1; $j <=10; $j++){
		$cnt = ($i - 1) * 10 + $j;
		# sequence profix
		$seqpro = join "/", $outdir, $cnt;
		$check = (join "_", $seqpro, $sstype).".txt";
		if(! -f $check){ print "last sequence: ", $cnt-1,"\n"; last;}
		`$runcb $seqpro $sstype $satype`;
	}
}
