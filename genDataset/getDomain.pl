#!/usr/bin/perl

#USAGE: get sequence name and domain number from .list file

$domfile = $ARGV[0];
$list = "/home/simochen/Prog/domainDS/Cath_nr_seq_ab.list";
$out = "/home/simochen/Prog/domainDS/domainInfo_ab";

open(dom, "<$domfile");
@lines = <dom>;
close(dom);

open(out, ">$out");

while ($line = shift(@lines)){
	$item = substr($line, 0, 5);
	if(($item eq "DSEQH") or ($item eq "DSEQS")){
		$str = substr($line, 10, length($line)-10);
		print out $str;	
	}
}

close(out);

open(out, "<$out");
@lines = <out>;
close(out);

open(out, ">$out");

$line = shift(@lines);
while ($line ne ""){
	print out $line;
	$res = "";
	$line = shift(@lines);
	while(substr($line, 0, 1) ne ">"){
		chomp($line);
		$res = $res.$line;
		$line = shift(@lines);
		if($line eq ""){ last; }
	}
	print out $res."\n";
}

close(out);

open(list, "<$list");
@lines = <list>;
close(list);

open(out, "<$out");
@seqs = <out>;
close(out);

open(out, ">$out");

while($line = shift(@lines)){
	chomp($line);
	@cp_seqs = @seqs;
	$flag = 0; 	
	while($seq = shift(@cp_seqs)){
		if(substr($seq, 5, 5) eq $line){
			$res = shift(@cp_seqs);
			print out $seq.$res;
			$flag = 1;
		}else{
			shift(@cp_seqs);	
		}
	}
	if($flag == 1){

	}
}

close(out);
