#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

if(@ARGV==0){
	$seq = "/home/simochen/Prog/domainDS/cullpdb_pc25_res3.0_R1.0_d160309_chains12283";
}else{
	$seq = $ARGV[0];
}
$regpdb = "/home/simochen/Prog/domainDS/cullpdb_seq.list";

open(seq, "<$seq");
@seqs = <seq>;
close(seq);

open(pdb, ">$regpdb");

shift(@seqs);
$line = shift(@seqs);
while ($line ne ""){
	$seqname = lc(substr($line, 0, 4));
	$seqtype = substr($line, 4, 1);
	$seq = $seqname.$seqtype;
	print pdb $seq."\n";
}

close(pdb);	