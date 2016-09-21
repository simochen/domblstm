#!/usr/bin/perl

use File::Basename;

$indir = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
if(@ARGV == 3){ $outdir = $indir; }
else{
	$outdir = $ARGV[3];
	if(!-e $outdir){ `mkdir $outdir`; }
}
#$disofile = $ARGV[0];

#@suffixlist = qw(.diso .blast .fasta .dom);
#$dir = dirname($disofile);
#$base = basename($disofile,@suffixlist);

for($i = $start; $i <= $end; $i++){
	$disofile = (join "/", $indir, $i).'.diso';
	$output = (join "/", $outdir, $i).'_diso.txt';

	open(diso, "<$disofile");
	@lines = <diso>;
	close(diso);

	open(out, ">$output");

	shift(@lines);
	shift(@lines);
	shift(@lines);

	while ($line = shift(@lines)){	
		$data = substr($line, 10, 4);
		print out "$data\n";
	}

	close(out);
}

