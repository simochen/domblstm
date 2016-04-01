#!/usr/bin/perl

#USAGE: get sequence name and domain number from .list file

$seq = "/home/simochen/Prog/domainDS/Cath_nr_s20o60_seq.list";
$seqname = "/home/simochen/Prog/domainDS/Cath_nr_s20o60_seqname.list";
$seq_ab = "/home/simochen/Prog/domainDS/Cath_nr_seq_ab.list";

open(seqname, "<$seqname");
@names = <seqname>;
close(seqname);

open(seq, "<$seq");
@seqs = <seq>;
close(seq);	

open(seq_ab, ">$seq_ab");

$seq = shift(@seqs);
$str = substr($seq, 0, 4);
while ($name = shift(@names)){
	chomp($name);
	$cnt = 0;
	while($str eq $name){
		$cnt++;
		if($cnt == 1){
			print seq_ab $seq;
		}
		$seq = shift(@seqs);
		$str = substr($seq, 0, 4);
	}
}
close(seq_ab);
