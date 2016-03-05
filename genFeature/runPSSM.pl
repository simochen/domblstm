#!/usr/bin/perl

$dir = "/home/chenxiao/dataset/multi";
$blast = "/home/chenxiao/blast/bin/blastpgp";
$db = "/home/mpiuser/ur90/uniref90";
$procPSSM = "/home/chenxiao/genFeature/getPSSM.pl";
for($i = 1; $i <= 354; $i++){
	$fasta = (join "/", $dir, $i).'.fasta';
	$pssm = (join "/", $dir, $i).'.pssm';
	print "blasting......................\n";
	`$blast -e 0.001 -j 3 -h 0.001 -i $fasta -d $db -Q $pssm`;
	print "generate PSSM features........\n";
	`$procPSSM $pssm`;
#COMBINE PSSM AND SSA FEATURES
	print "comebine feature file.........\n";
	$psf = (join "/", $dir, $i).'_pssm.txt';
	open(psf, "<$psf");
	@pssmlines = <psf>;
	close(psf);
	$ssa = (join "/", $dir, $i).'_ssa.txt';
	open(ssa, "<$ssa");
	@ssalines = <ssa>;
	close(ssa);
	$out = (join "/", $dir, $i).'.txt';
	open(out, ">$out");
	while($ssaline = shift(@ssalines)){
		$pssmline = shift(@pssmlines);
		chomp($pssmline);
		print out $pssmline." ".$ssaline;
	}
	close(out);
	print "done process sequence",$i,"\n";
}
