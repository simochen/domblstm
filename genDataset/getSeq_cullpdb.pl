#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$seq = $ARGV[0];
$regpdb = "/home/simochen/Prog/domainDS/cullpdb_seq.fasta";

open(seq, "<$seq");
@seqs = <seq>;
close(seq);

open(pdb, ">$regpdb");

$line = shift(@seqs);
while ($line ne ""){
	$seqname = lc(substr($line, 1, 4));
	$seqtype = substr($line, 5, 1);
	$seq = ">".$seqname.$seqtype;
	print pdb $seq."\n";
	$res = "";
	$line = shift(@seqs);
	while(substr($line, 0, 1) ne ">"){
		chomp($line);
		$res = $res.$line;
		$line = shift(@seqs);
		if($line eq ""){ last; }
	}
	print pdb $res."\n";
}

close(pdb);	