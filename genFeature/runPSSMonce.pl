#!/usr/bin/perl

# USAGE: runPSSMonce.pl dir seqnum

$dir = $ARGV[0];
$seqnum = $ARGV[1];

$blast = "/home/chenxiao/blast/bin/blastpgp";
$db = "/home/mpiuser/ur90/uniref90";
$procPSSM = "/home/chenxiao/genFeature/getPSSM.pl";
$fasta = (join "/", $dir, $seqnum).'.fasta';
$pssm = (join "/", $dir, $seqnum).'.pssm';

print "blasting......................\n";
`$blast -e 0.001 -j 3 -h 0.001 -i $fasta -d $db -Q $pssm`;

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
