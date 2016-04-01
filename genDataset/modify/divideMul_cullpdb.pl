#!/usr/bin/perl

#USAGE: list2seq_cullpdb.pl list outseq

$origin = "/home/simochen/Prog/domainDS/cullpdb_multi.fasta";
$modify = "/home/simochen/Prog/domainDS/cullpdb_multi_1.fasta";
$multi = "/home/simochen/Prog/domainDS/m_multi.list";
$disc = "/home/simochen/Prog/domainDS/m_disc.list";

open(ori, "<$origin");
@lines = <ori>;
close(ori);

open(mod, "<$modify");
@mod = <mod>;
close(mod);

open(listM, ">$multi");
open(listD, ">$disc");

$seq = shift(@mod);
$cnt = 0;
while($line = shift(@lines)){
	$cnt++;
	if($line eq $seq){
		print listM $cnt."\n";
		shift(@mod);
		$seq = shift(@mod);
	}else{
		print listD $cnt."\n";
	}
	shift(@lines);
}

close(listD);
close(listM);
