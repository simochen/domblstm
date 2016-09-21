#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$cath = "/home/chenxiao/domainDS/CathDomainSeqs.COMBS.v4.0.0";
$cullpdb = "/home/chenxiao/domainDS/cullpdb_sort.fasta";
$inseq = "/home/chenxiao/domainDS/cullpdb_cath_seq.fasta";
$indom = "/home/chenxiao/domainDS/cullpdb_cath.dom";


open(cath, "<$cath");
@cath = <cath>;
close(cath);

open(pdb, "<$cullpdb");
@lines = <pdb>;
close(pdb);

open(seq, ">$inseq");
open(dom, ">$indom");

$cnt = 0;
while($line = shift(@lines)){
	$str = substr($line, 1, 5);
	@cp_cath = @cath;
	$flag = 0;
	while($dom = shift(@cp_cath)){
		if(substr($dom, 12, 5) eq $str){
			$dominfo = substr($dom, 12, length($dom)-12);
			$res = shift(@cp_cath);
			print dom ">".$dominfo.$res;
			$flag = 1;
		}else{
			shift(@cp_cath);
			if($flag == 1){ last; }
		}
	}
	if($flag == 1){
		print seq $line;
		$line = shift(@lines);
		print seq $line;
	}else{
		shift(@lines);
		$cnt++;
		print $str."\t".$cnt."\n";
	}
}

close(dom);
close(seq);
