#!/usr/bin/perl

#USAGE: getFeat+diso.pl ssadir disodir seqNum (outdir)

$ssadir = $ARGV[0];
$disodir = $ARGV[1];
$start = $ARGV[2];
$end = $ARGV[3];
if(@ARGV == 4){ $outdir = $disodir; }
else{ 
	$outdir = $ARGV[4];
	if(!-e $outdir){ `mkdir $outdir`; }
}

for($i = $start; $i <= $end; $i++){
	
#COMBINE ssa AND diso FEATURES
	print "comebine feature file.........\n";
	$psf = (join "/", $ssadir, $i).'.txt';
	open(psf, "<$psf");
	@ssalines = <psf>;
	close(psf);
	$diso = (join "/", $disodir, $i)."_diso.txt";
	open(diso, "<$diso");
	@disolines = <diso>;
	close(diso);
	$out = (join "/", $outdir, $i).'.txt';
	open(out, ">$out");
	while($disoline = shift(@disolines)){
		$ssaline = shift(@ssalines);
		chomp($ssaline);
		print out $ssaline." ".$disoline;
	}
	close(out);
	print "done process sequence",$i,"\n";
}
