#!/usr/bin/perl

use File::Basename;

$seqfile = $ARGV[0];

@suffixlist = qw(.pssm .blast .fasta .dom);
$dir = dirname($seqfile);
$base = basename($seqfile,@suffixlist);

$dom = (join "/", $dir, $base).'_dom.txt';
$target = (join "/", $dir, $base).'_target.txt';

open(seq, "<$seqfile");
@lines = <seq>;
close(seq);

open(dom, ">$dom");
open(tar, ">$target");

shift(@lines);
shift(@lines);

$domNum = 1;
while ($line = shift(@lines)){
#line1: sequence name	
	print dom ">$line";
#line2: number of residues
	$len = shift(@lines);
	chomp($len);
#line3: sequence
	$line = shift(@lines);
	print dom "$line\n";
#line4: SS (H:helix, E: strand, C: coil)
	$outSS = (join "/", $dir, $domNum).'.ss';
	open(ss, ">$outSS");
	$line = shift(@lines);
	for($i = 0; $i < $len; $i++){
		$ss = substr($line, $i, 1);
		if ($ss eq "H"){ print ss "1 0 0\n"; }
		elsif ($ss eq "E"){ print ss "0 1 0\n"; }
		else{ print ss "0 0 1\n"; }
	}
	close(ss);
#line5: SA (e:exposed, b:buried at 25% threshold)
	$outSA = (join "/", $dir, $domNum).'.sa';
	open(sa, ">$outSA");	
	$line = shift(@lines);
	for($i = 0; $i < $len; $i++){
		$sa = substr($line, $i, 1);
		if ($sa eq "e"){ print sa "1\n"; }
		else{ print sa "0\n"; }
	}
	close(sa);
#line6: domain number, position
	shift(@lines);
#line7: (T/N) domain boundary region
	$line = shift(@lines);
	for($i = 0; $i < $len; $i++){
		$tar = substr($line, $i, 1);
		if ($tar eq "T"){ print tar "1 "; }
		else{ print tar "0 "; }
	}
	print tar "\n";
#line8: empty line
	shift(@lines);

# COMBINE SS AND SA FILES
	$outF = (join "/", $dir, $domNum).'_ssa.txt';
	open(ss, "<$outSS");
	@ssFi = <ss>;
	close(ss);
	open(sa, "<$outSA");
	@saFi = <sa>;
	close(sa);
	open(fea, ">$outF");
	for($i = 0; $i < $len; $i++){
		$ssF = shift(@ssFi);
		$saF = shift(@saFi); 
		chomp($ssF);
		print fea $ssF." ".$saF;
	}
	close(fea);
	`rm $outSS $outSA`;

	$domNum++;
}

close(dom, tar);

