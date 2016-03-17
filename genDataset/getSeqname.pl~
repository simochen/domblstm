#!/usr/bin/perl

#USAGE: get sequence name and domain number from .list file

$list = $ARGV[0];
$out = "/home/simochen/Prog/domainDS/Cath_nr_s20o60_seqname.list";

open(list, "<$list");
@lines = <list>;
close(list);

open(out, ">$out");
close(out);	

while ($line = shift(@lines)){
	$seq = substr($line, 0, 4);
	$dom = substr($line, 5, 2);
	
	open(out, "<$out");
	@exist = <out>;
	close(out);
	
	$flag = 0;
	foreach(@exist){
		if(substr($_, 0, 4) eq $seq){
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

#open(out, "<$out");
#@out = <out>;
#close(out);

#open(out, ">$out");
	
#while($seqname = shift(@out)){
#	chomp($seqname);
#	print out $seqname." ";
#}

#close(out);
