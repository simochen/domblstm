#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$seq = $ARGV[0];
$cath = "/home/simochen/Prog/domainDS/CathDomainSeqs.COMBS.v4.0.0";
$regpdb = "/home/simochen/Prog/domainDS/cullpdb_seq.fasta";
$inseq = "/home/simochen/Prog/domainDS/cullpdb_cath_seq.fasta";
$indom = "/home/simochen/Prog/domainDS/cullpdb_cath_seq.dom";


open(cath, "<$cath");
@lines = <cath>;
close(cath);

open(pdb, "<$regpdb");
@pdb = <pdb>;
close(pdb);

open(seq, ">$inseq");
open(dom, ">$indom");

while($line = shift(@lines)){
	$str = substr($line, 12, 5);
	@cp_pdb = @pdb;
	$flag = 0;
	while($seq = shift(@cp_pdb)){
		if(substr($seq, 1, 5) eq $line){
			$res = shift(@cp_pdb);
			if(length($res) > 80){
				print seq $seq.$res;
				$dominfo = substr($line, 12, 7);
				print dom ">".$dominfo."\n";
				$domres = shift(@lines);
				print dom $domres;
				$flag = 1;
			}
			last;
		}else{
			shift(@cp_pdb);	
		}
	}
	if($flag == 0){ shift(@lines); }
}
close(dom);
close(seq);