#!/usr/bin/perl

# USAGE: getSSA.pl sstype satype segNum indir (outdir)
# without calling other perl files (getSS.pl, getACC.pl, etc.)

use File::Basename;

$sstype = $ARGV[0];
$satype = $ARGV[1];
$segNum = $ARGV[2];
$indir = $ARGV[3];
if(@ARGV == 4){ $outdir = $indir; }
else{ $outdir = $ARGV[4]; }

@suffixlist = qw(.ss .ss8 .acc .acc20 .fasta);
#$dir = dirname($seqfile);
#$base = basename($seqfile,@suffixlist);

for($i = 1; $i <= $segNum; $i++){
	$base = "seg".$i;
	$profix = join "/", $indir, $base;
	$ssfile = join ".", $profix, $sstype;
	$safile = join ".", $profix, $satype;
	open(ss, "<$ssfile");
	@sslines = <ss>;
	close(ss);
	open(sa, "<$safile");
	@salines = <sa>;
	close(sa);
	
	$j = 1;
	while ($sslines = shift(@sslines)){
		$cnt = ($i - 1) * 10 + $j;
		#sequence profix
		$seqpro = join "/", $outdir, $cnt;
		$outF = $seqpro."_".$sstype.$satype.".txt";
		open(out, ">$outF");
	#line1: sequence name	
		shift(@salines);
	#line2: SS or SA
		$ssline = shift(@sslines);
		$saline = shift(@salines);
		chomp($ssline);
		chomp($saline);
		$pos = 0;
		for($k = 0; $k < length($ssline); $k++){
			$ss = substr($ssline, $k, 1);
			if($sstype eq "ss"){
				if ($ss eq "H"){ print out "1 0 0 "; }
				elsif ($ss eq "E"){ print out "0 1 0 "; }
				else{ print out "0 0 1 "; }
			}else{
				if ($ss eq "G"){ print out "0 0 0 "; }
				elsif ($ss eq "H"){ print out "0 0 1 "; }
				elsif ($ss eq "I"){ print out "0 1 0 "; }
				elsif ($ss eq "T"){ print out "0 1 1 "; }
				elsif ($ss eq "E"){ print out "1 0 0 "; }
				elsif ($ss eq "B"){ print out "1 0 1 "; }
				elsif ($ss eq "S"){ print out "1 1 0 "; }
				else{ print out "1 1 1 "; }
			}
			if($satype eq "acc"){
				$sa = substr($saline, $k, 1);
				if ($sa eq "e"){ print out "1\n"; }
				else{ print out "0\n"; }
			}else{
				$ind = index($saline, " ", $pos);
				if($ind != -1){
					$sa20 = substr($saline, $pos, $ind-$pos);
					print out $sa20."\n";
					$pos = $ind+1;
				}else{
					$sa20 = substr($saline, $pos, length($saline)-$pos);
					print out $sa20."\n";
				}
			}
		}
		close(out);

		$j++;
	}
}
