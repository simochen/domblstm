#!/usr/bin/perl

use File::Basename;

$sa20file = $ARGV[0];
$outdir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$indir = dirname($sa20file);
$base = basename($sa20file,@suffixlist);

open(sa20, "<$sa20file");
@lines = <sa20>;
close(sa20);

$segNum = substr($base,3,length($base)-3);
$i = 1;
while ($line = shift(@lines)){
	$cnt = ($segNum - 1) * 10 + $i;
	$outSA20 = (join "/", $outdir, $cnt).'_acc20.txt';
	open(outSA20, ">$outSA20");
#line1: sequence name	

#line2: SA20 (-5,0,5...95)
	$line = shift(@lines);
    chomp($line);
	$pos = 0;
	while(1){
		$ind = index($line, " ", $pos);
		if($ind != -1){
			$sa20 = substr($line, $pos, $ind-$pos);
			print outSA20 $sa20."\n";
			$pos = $ind+1;
		}else{
			$sa20 = substr($line, $pos, length($line)-$pos);
			print outSA20 $sa20."\n";
			last;
		}			
	}
	close(outSA20);

	$i++;
}
