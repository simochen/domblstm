#!/usr/bin/perl

#USAGE: classify multi-domain and single-domain sequence

$domainList = "/home/simochen/Prog/domainDS/domainInfo_ab";
$domSingle = "/home/simochen/Prog/domainDS/dom_ab_single";
$domMulti = "/home/simochen/Prog/domainDS/dom_ab_multi";
$domUnc = "/home/simochen/Prog/domainDS/dom_ab_unc";
$seqList = "/home/simochen/Prog/domainDS/PDB_cath_nr_seq_ab.fasta";
$seqSingle = "/home/simochen/Prog/domainDS/seq_ab_single";
$seqMulti = "/home/simochen/Prog/domainDS/seq_ab_multi";
$seqUnc = "/home/simochen/Prog/domainDS/seq_ab_unc";

open(domlist, "<$domainList");
@dlines = <domlist>;
close(domlist);

open(seqlist, "<$seqList");
@slines = <seqlist>;
close(seqlist);

open(seqS, ">$seqSingle");
open(seqM, ">$seqMulti");
open(seqU, ">$seqUnc");
open(domS, ">$domSingle");
open(domM, ">$domMulti");
open(domU, ">$domUnc");

$dline = shift(@dlines);
$doms = substr($dline, 5, 5);
$domd = substr($dline, 10, 2);
while($sline = shift(@slines)){
	$seq = substr($sline, 1, 5);
	$cnt = 0;
	$maxdom = 0;
	while($doms eq $seq){
		if($domd eq "00"){
			print seqS $sline;
			$sline = shift(@slines);
			print seqS $sline;	
			print domS $dline;
			$dline = shift(@dlines);
			print domS $dline;
		}else{
			$cnt++;
			$domNum = $domd+0;
			if($domNum > $maxdom){ $maxdom = $domNum; }

			if($cnt == 1){
				$marks = $sline;
				@markseq = @slines;
				$markd = $dline;
				@markdom = @dlines;
			}
			shift(@dlines);
		}
		$dline = shift(@dlines);
		$doms = substr($dline, 5, 5);
		$domd = substr($dline, 10, 2);
	}
	if($maxdom != $cnt){
		print seqU $marks;
		$marks = shift(@markseq);
		print seqU $marks;
		for($i = 1; $i <= 2*$cnt; $i++){
			print domU $markd;
			$markd = shift(@markdom);	
		}
	}elsif($cnt != 0){
		print seqM $marks;
		$marks = shift(@markseq);
		print seqM $marks;
		for($i = 1; $i <= 2*$cnt; $i++){
			print domM $markd;
			$markd = shift(@markdom);	
		}
	}
}
close(domU);
close(domM);
close(domS);
close(seqU);
close(seqM);
close(seqS);
