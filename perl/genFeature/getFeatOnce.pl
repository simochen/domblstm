#!/usr/bin/perl

$dir = $ARGV[0];
$seqnum = $ARGV[1];

$procPSSM = "/home/chenxiao/genFeature/getPSSM.pl";
$pssm = (join "/", $dir, $seqnum).'.pssm';
	
print "generate PSSM features........\n";
`$procPSSM $pssm $dir`;
#COMBINE PSSM AND SSA FEATURES
print "comebine feature file.........\n";
$psf = (join "/", $dir, $seqnum).'_pssm.txt';
open(psf, "<$psf");
@pssmlines = <psf>;
close(psf);
$ssa = (join "/", $dir, $seqnum).'_ssa.txt';
open(ssa, "<$ssa");
@ssalines = <ssa>;
close(ssa);
$out = (join "/", $dir, $seqnum).'.txt';
open(out, ">$out");
while($ssaline = shift(@ssalines)){
	$pssmline = shift(@pssmlines);
	chomp($pssmline);
	print out $pssmline." ".$ssaline;
}
close(out);
print "done process sequence",$seqnum,"\n";
