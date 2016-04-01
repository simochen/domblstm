#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$cath = "/home/simochen/Prog/domainDS/CathDomainSeqs.COMBS.v4.0.0";
$regpdb = "/home/simochen/Prog/domainDS/cullpdb_seq.list";
$inlist = "/home/simochen/Prog/domainDS/cullpdb_cath.list";
$indom = "/home/simochen/Prog/domainDS/cullpdb_cath.dom";


open(cath, "<$cath");
@cath = <cath>;
close(cath);

open(pdb, "<$regpdb");
@lines = <pdb>;
close(pdb);

open(list, ">$inlist");
open(dom, ">$indom");

$cnt = 0;
while($line = shift(@lines)){
	chomp($line);
	@cp_cath = @cath;
	$flag = 0;
	while($dom = shift(@cp_cath)){
		if(substr($dom, 12, 5) eq $line){
			$dominfo = substr($dom, 12, 7);
			$res = shift(@cp_cath);
			print dom ">".$dominfo."\n".$res;
			$flag = 1;
		}else{
			shift(@cp_cath);
			if($flag == 1){ last; }
		}
	}
	if($flag == 1){
		print list $line."\n";
	}else{
		$cnt++;
		print $line."\t".$cnt."\n";
	}
}

close(dom);
close(list);
