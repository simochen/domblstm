#!/usr/bin/perl

#USAGE: list2seq_cullpdb.pl list outseq

$cullpdb = "/home/chenxiao/domainDS/cullpdb_seq.fasta";
#$list = "/home/chenxiao/domainDS/cullpdb_cath.list";
$list = $ARGV[0];
#$seq = "/home/chenxiao/domainDS/cullpdb_cath_seq.fasta";
$seq = $ARGV[1];

open(list, "<$list");
@lines = <list>;
close(list);

open(pdb, "<$cullpdb");
@pdb = <pdb>;
close(pdb);

open(seq, ">$seq");

while($line = shift(@lines)){
	chomp($line);
	@cp_pdb = @pdb;
	while($seq = shift(@cp_pdb)){
		if(substr($seq, 1, 5) eq $line){
			$res = shift(@cp_pdb);
			if(length($res) > 80){
				print seq $seq.$res;
				last;
			}
		}
	}
}

close(seq);
