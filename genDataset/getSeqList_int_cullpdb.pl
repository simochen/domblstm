#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$cath = "/home/simochen/Prog/domainDS/CathDomainSeqs.COMBS.v4.0.0";
$regpdb = "/home/simochen/Prog/domainDS/cullpdb_seq.list";
$inseq = "/home/simochen/Prog/domainDS/cullpdb_cath_seq.list";
$indom = "/home/simochen/Prog/domainDS/cullpdb_cath_seq.dom";


open(cath, "<$cath");
@cath = <cath>;
close(cath);

open(pdb, "<$regpdb");
@lines = <pdb>;
close(pdb);

open(seq, ">$inseq");
open(dom, ">$indom");

while($line = shift(@lines)){
	chomp($line);
	@cp_cath = @cath;
	while($dom = shift(@cp_cath)){
		if(substr($dom, 12, 5) eq $line){
			$dominfo = substr($dom, 12, 7);
			$res = shift(@cp_cath);
			print dom ">".$dominfo.$res;
			print seq $line."\n";
			last;
		}else{
			shift(@cp_cath);	
		}
	}
}
close(dom);
close(seq);
