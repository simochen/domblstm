#!/usr/bin/perl

#USAGE: getFeat.pl pssmdir ssadir seqNum (outdir)

$pssmdir = $ARGV[0];
$ssadir = $ARGV[1];
$ssatype = $ARGV[2];
$seqNum = $ARGV[3];
if(@ARGV == 4){ $outdir = $ssadir; }
else{ 
	$outdir = $ARGV[4];
	if(!-e $outdir){ `mkdir $outdir`; } 
}

$procPSSM = "/home/chenxiao/genFeature/getPSSM.pl";
for($i = 1; $i <= $seqNum; $i++){
	$pssm = (join "/", $pssmdir, $i).'.pssm';
	
	print "generate PSSM features........\n";
	`$procPSSM $pssm $pssmdir`;
#COMBINE PSSM AND SSA FEATURES
	print "comebine feature file.........\n";
	$psf = (join "/", $pssmdir, $i).'_pssm.txt';
	open(psf, "<$psf");
	@pssmlines = <psf>;
	close(psf);
	$ssa = (join "/", $ssadir, $i)."_".$ssatype.".txt";
	open(ssa, "<$ssa");
	@ssalines = <ssa>;
	close(ssa);
	$out = (join "/", $outdir, $i).'.txt';
	open(out, ">$out");
	while($ssaline = shift(@ssalines)){
		$pssmline = shift(@pssmlines);
		chomp($pssmline);
		print out $pssmline." ".$ssaline;
	}
	close(out);
	print "done process sequence",$i,"\n";
}
