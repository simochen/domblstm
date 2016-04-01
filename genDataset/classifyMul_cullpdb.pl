#!/usr/bin/perl

#USAGE: classify multi-domain and single-domain sequence

$domainList = "/home/simochen/Prog/domainDS/cullpdb_cath.dom";
$domSingle = "/home/simochen/Prog/domainDS/cullpdb_single.dom";
$domMulti = "/home/simochen/Prog/domainDS/cullpdb_multi.dom";
$domDisc = "/home/simochen/Prog/domainDS/cullpdb_disc.dom";
$domUnk = "/home/simochen/Prog/domainDS/cullpdb_unk.dom";
$seqList = "/home/simochen/Prog/domainDS/cullpdb_cath_seq.fasta";
$seqSingle = "/home/simochen/Prog/domainDS/cullpdb_single.fasta";
$seqMulti = "/home/simochen/Prog/domainDS/cullpdb_multi.fasta";
$seqDisc = "/home/simochen/Prog/domainDS/cullpdb_disc.fasta";
$seqUnk = "/home/simochen/Prog/domainDS/cullpdb_unk.fasta";

open(domlist, "<$domainList");
@dlines = <domlist>;
close(domlist);

open(seqlist, "<$seqList");
@slines = <seqlist>;
close(seqlist);

open(seqS, ">$seqSingle");
open(seqM, ">$seqMulti");
open(seqD, ">$seqDisc");
open(seqU, ">$seqUnk");
open(domS, ">$domSingle");
open(domM, ">$domMulti");
open(domD, ">$domDisc");
open(domU, ">$domUnk");

$dline = shift(@dlines);
$doms = substr($dline, 1, 5);
$domd = substr($dline, 6, 2);
#the number of segment in domain
$segnum = ($dline =~ /_/g) + 1;
while($sline = shift(@slines)){
	$seq = substr($sline, 1, 5);
	$cnt = 0;
	$maxdom = 0;
	$disf = 0;
	while($doms eq $seq){
		if($domd eq "00"){
			if($segnum == 1){
				print seqS $sline;
				$sline = shift(@slines);
				print seqS $sline;	
				print domS $dline;
				$dline = shift(@dlines);
				print domS $dline;
			}else{
				print seqD $sline;
				$sline = shift(@slines);
				print seqD $sline;	
				print domD $dline;
				$dline = shift(@dlines);
				print domD $dline;
			}
		}else{
			$cnt++;
			$domNum = $domd+0;
			if($domNum > $maxdom){ $maxdom = $domNum; }
			
			if($segnum > 1){ $disf = 1; }

			if($cnt == 1){
				$marks = $sline;
				@markseq = @slines;
				$markd = $dline;
				@markdom = @dlines;
			}
			shift(@dlines);
		}
		$dline = shift(@dlines);
		$doms = substr($dline, 1, 5);
		$domd = substr($dline, 6, 2);
		$segnum = ($dline =~ /_/g) + 1;
	}
	if(($maxdom != $cnt) or ($cnt == 1)){
		print seqU $marks;
		$marks = shift(@markseq);
		print seqU $marks;
		for($i = 1; $i <= 2*$cnt; $i++){
			print domU $markd;
			$markd = shift(@markdom);	
		}	
	}elsif($disf == 1){
		print seqD $marks;
		$marks = shift(@markseq);
		print seqD $marks;
		for($i = 1; $i <= 2*$cnt; $i++){
			print domD $markd;
			$markd = shift(@markdom);	
		}
	}elsif($cnt > 1){
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
close(domD);
close(domM);
close(domS);
close(seqU);
close(seqD);
close(seqM);
close(seqS);
