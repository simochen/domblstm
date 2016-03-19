#!/usr/bin/perl

#USAGE: get sequence name and residues from .txt file

$seq = $ARGV[0];
$list = "/home/simochen/Prog/domainDS/Cath_nr_seq_ab.list";
$regpdb = "/home/simochen/Prog/domainDS/PDB_nr_s20o60_seq_ab.fasta";
$overlap = "/home/simochen/Prog/domainDS/Cath_nr_seq_ab.list";
$out = "/home/simochen/Prog/domainDS/PDB_cath_nr_s20o60_seq_ab.fasta";

open(seq, "<$seq");
@seqs = <seq>;
close(seq);

open(pdb, ">$regpdb");

$line = shift(@seqs);
while ($line ne ""){
	$seqname = lc(substr($line, 1, 4));
	$seqtype = substr($line, 6, 1);
	$seq = ">".$seqname.$seqtype;
	print pdb $seq."\n";
	$res = "";
	$line = shift(@seqs);
	while(substr($line, 0, 1) ne ">"){
		chomp($line);
		$res = $res.$line;
		$line = shift(@seqs);
		if($line eq ""){ last; }
	}
	print pdb $res."\n";
}

close(pdb);	

open(list, "<$list");
@lines = <list>;
close(list);

open(pdb, "<$regpdb");
@pdb = <pdb>;
close(pdb);

open(out, ">$out");
open(over, ">$overlap");

while($line = shift(@lines)){
	chomp($line);
	@cp_pdb = @pdb;
	$flag = 0; 	
	while($seq = shift(@cp_pdb)){
		if(substr($seq, 1, 5) eq $line){
			$res = shift(@cp_pdb);
			if(length($res) > 80){
				print out $seq.$res;
				$flag = 1;
			}
			last;
		}else{
			shift(@cp_pdb);	
		}
	}
	if($flag == 1){
		print over $line."\n";	
	}
}

close(over);
close(out);
