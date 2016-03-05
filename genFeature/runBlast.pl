#!/usr/bin/perl

$dir = $ARGV[0];
$blast = "/home/chenxiao/blast/bin/blastpgp";
$db = "/home/mpiuser/ur90/uniref90";
for($i = 42; $i <= 354; $i++){
	$fasta = (join "/", $dir, $i).'.fasta';
	$pssm = (join "/", $dir, $i).'.pssm';

	print "blasting......................\n";
	`$blast -e 0.001 -j 3 -h 0.001 -i $fasta -d $db -Q $pssm`;
	print "done blast sequence",$i,"\n";
}
