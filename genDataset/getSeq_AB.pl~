#!/usr/bin/perl

#USAGE: get sequence name and domain number from .list file

$list = $ARGV[0];
$out = "/home/simochen/Prog/domainDS/Cath_nr_s20o60_seq.list";

open(list, "<$list");
@lines = <list>;
close(list);

open(out, ">$out");
close(out);	

while ($line = shift(@lines)){
	$seq = substr($line, 0, 5);
	$dom = substr($line, 5, 2);
	if($dom eq "00"){
		open(out, ">>$out");
		print out $seq."\n";
		close(out);		
	}else{
		open(out, "<$out");
		@exist = <out>;
		close(out);
	
		$flag = 0;
		foreach(@exist){
			if(substr($_, 0, 5) eq $seq){
				$flag = 1;
				last;	
			}
		}

		if($flag == 0){
			open(out, ">>$out");
			print out $seq."\n";
			close(out);			
		}
	}
}
