#!/usr/bin/perl

use File::Basename;

$domfile = $ARGV[0];
$dir = $ARGV[1];

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta .txt);
#$dir = dirname($seqfile);
#$base = basename($domfile,@suffixlist);

open(dom, "<$domfile");
@lines = <dom>;
close(dom);

$cnt = 1;
$batch = 1;
while ($line = shift(@lines)){
	if ($cnt == 1){
		$base = "seg".$batch;
		$fasta = (join "/", $dir, $base).'.fasta';
		open(fasta, ">$fasta");
	}
#line1: sequence name	
	print fasta $line;
#line2: sequence
	$line = shift(@lines);
	print fasta $line;

	if ($cnt == 10){ $cnt = 1; close(fasta); $batch++; }
	else{ $cnt++; }
}

close(fasta);

