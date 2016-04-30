#!/usr/bin/perl -w

################################################################################
# Infer domain boundary from the DOMpro prediction
# Input:  DOMpro prediction file, output file 
# Author: Jianlin Cheng, June 23, 2004
# Limitaion: This script predicts at most three domains. But certainly, user can infer the any
#            number of domains from the DOMpro prediction by himself/herself.
#################################################################################

use File::Basename;

$infodir = "/home/simochen/Downloads/dataset";

if (@ARGV != 1)
{
	die "need 1 parameters: input domain prediction file.\n"; 
}

$input_file = shift @ARGV;

open(INPUT, "$input_file") || die "can't open the input file.\n";

@suffixlist = qw(.fasta .dom .out);
$dir = dirname($input_file);
$p = rindex($dir, "/");
$type = substr($dir, $p+1, length($dir)-$p-1);
$base = basename($input_file, @suffixlist);
$outfile = (join "/", $infodir, $type).'.dom';

#minimum consective T
$mincon = 2; 
#minimum length of T region
$minwin = 5; 
#maximum length of consective N
$maxn = 3; 

$pseq = <INPUT>;
chomp $pseq;
$ptarget = <INPUT>;
chomp $ptarget; 
$seq_length = length($ptarget);

if ($seq_length > 350)
{
	$minwin = 1; 
	$mincon = 1; 
}

close INPUT; 
if (length($ptarget) != length($pseq) )
{
	die "length doesn't match.\n"; 
}
	
#for each transition region, we need to have the following information:
# a) start T
# b) end T
# c) max number of consective T
# d) length of T region

#start pos of T region
@start = ();
#end pos of T region
@end = (); 
#max number of consective T
@cont = (); 
# if pos is in T region
$bin = 0; 
for ($i = 0; $i < length($ptarget); $i++)
{

	$pt = substr($ptarget,$i,1); 
	if ( $pt eq "T" || $pt eq "S")
	{
		if ($bin == 0)
		{
			#set start position
			$st = $i+1; 
			#current number of consective T
			$conm = 1; 
			#maximum number of consective T
			$maxt = 1; 
			$bin = 1; 
			#number of consective N
		}
		else
		{
			$conm++; 
		}
		#current number of consective N
		$conn = 0;  
	}
	else
	{
		if ($bin == 1)
		{
			if ($conm > $maxt)
			{
				$maxt = $conm; 
			}
			$conm = 0; 
			$conn++; 	
			if ($conn > $maxn)
			{
				#the region ends
				$bin = 0; 
				#end region
				$et = $i - 3;  
				if ($et < $st)
				{
					die "bug, et >= st.\n"; 
				}
				if ($et - $st + 1 >= $minwin && $maxt >= $mincon)
				{
					push @start, $st;
					push @end, $et;
					push @cont, $maxt; 
				}
			}
		}
	}
}

#infer domain
#choose top 4 candidates according to length
$f1 = $f2 = $f2 = $f4 = -1; 
$w1 = $w2 = $w3 = $w4 = 0; 
for ($i = 0; $i < @start; $i++)
{
	$size = $end[$i] - $start[$i] + 1; 
	if ($size > $w1)
	{
		$w2 = $w1;
		$f2 = $f1; 

		$w1 = $size;
		$f1 = $i; 
	}
	elsif ($size > $w2)
	{
		$w3 = $w2;
		$f3 = $f2;

		$w2 = $size;
		$f2 = $i; 
	}
	elsif ($size > $w3)
	{
		$w4 = $w3;
		$f4 = $f3;

		$w3 = $size;
		$f3 = $i; 
	}
	elsif ($size > $w4)
	{
		$w4 = $size;
		$f4 = $i; 
	}
}

#print "top boundary regions: $w1, $w2, $w3, $w4\n"; 
#order by the max consective T. 
if ($w1 > 0 && $w1 == $w2 && $cont[$f1] < $cont[$f2])
{
	$tmp = $f1;
	$f1 = $f2;
	$f2 = $tmp; 
}
if ($w2 > 0 && $w2 == $w3 && $cont[$f2] < $cont[$f3])
{
	$tmp = $f2;
	$f2 = $f3;
	$f3 = $tmp; 
}
if ($w3 > 0 && $w3 == $w4 && $cont[$f3] < $cont[$f4])
{
	$tmp = $f3;
	$f3 = $f4;
	$f4 = $tmp; 
}

#choose domains
$min_dom_len = 38; 
$length = length($pseq); 
#print "seq length: $length\n"; 

$dom_num = 1; 
@bound = ();
push @bound, 1; 
@bound_2 = (); 
push @bound_2, 1; 
if ($f1 == -1)
{
	#single domain case
	#print "single domain\n"; 
	;
}
else
{
	#choose bound 1 
	$cur = -1; 
	$min_win = 8; 
	if ($seq_length > 250)
	{
		$min_win = 6; 
	}
	if ($seq_length > 350)
	{
		$min_win = 1; 
	}
	if ($seq_length > 800)
	{
		$min_win = 0; 
	}
	$m1 = int(($end[$f1] + $start[$f1])/2); 
	if ($w1 >= $min_win &&  $m1 >= $min_dom_len && ($length - $m1) >= $min_dom_len)
	{
		$dom_num++; 	
		push @bound, $m1; 
		push @bound_2, $m1; 
		$cur = 1; 
	}
	elsif($w2 > $min_win)
	{
		$m1 = int(($end[$f2] + $start[$f2])/2); 
		if ($m1 >= $min_dom_len && ($length - $m1) >= $min_dom_len)
		{
			$dom_num++; 	
			push @bound, $m1; 
			push @bound_2, $m1; 
			$cur = 2; 
		}
		elsif($w3 > $min_win)
		{
			$m1 = int(($end[$f3] + $start[$f3])/2); 
			if ($m1 >= $min_dom_len && ($length - $m1) >= $min_dom_len)
			{
				$dom_num++; 	
				push @bound, $m1; 
				push @bound_2, $m1; 
				$cur = 3; 
			}
		}
	}

	#choose bound 2 if necessary
	#min window size of second boundary
	$min_win = 7; 
	$min_dom_len = 50; 
	if ($seq_length > 350)
	{
		$min_win = 6; 
	}
	if ($seq_length > 400)
	{
		$min_win = 5; 
	}
	if ($seq_length > 500)
	{
		$min_win = 3; 
	}
	if ($seq_length > 800)
	{
		$min_win = 2; 
	}

	if ($cur == 1)
	{
		if ($w2 >= $min_win)
		{
			$m2 = int(($end[$f2] + $start[$f2])/2); 
			#print "m2: $m2\n"; 
			if ($m2 > $min_dom_len && ($length-$m2) > $min_dom_len && abs($m2 - $m1) > $min_dom_len)
			{
				$dom_num++; 	
				#push @bound, $m2; 
				push @bound_2, $m2; 
			}
		}
		
	}
	elsif ($cur == 2)
	{
		if ($w3 >= $min_win)
		{
			$m2 = int(($end[$f3] + $start[$f3])/2); 
			if ($m2 > $min_dom_len && ($length-$m2) > $min_dom_len && abs($m2 - $m1) > $min_dom_len)
			{
				$dom_num++; 	
				#push @bound, $m2; 
				push @bound_2, $m2; 
			}
		}
	}
	#multi-domain case
	#print "dom_num: $dom_num\n"; 
}
if ($seq_length < 100)
{
	#for domain having less than 100 aa, only one domain is allowed. 
	@bound = ();
	@bound_2 = (); 
	push @bound, 1; 
	push @bound_2, 1; 
}
push @bound, $length; 
push @bound_2, $length; 
@bound = sort {$a<=>$b} @bound; 

open(out, ">>$outfile");
print out "$base\n";

print out "number of predicted domains: $dom_num\n";
if ($dom_num <= 2)
{

	$bound[0] = 0; 
	for ($i = 1; $i < @bound; $i++)
	{
		print out "domain $i: "; 
		print out $bound[$i-1] + 1, " - ", $bound[$i], "\n";
	}
}

else
{
	$bound_2[0] = 0; 
	@bound_2 = sort {$a<=>$b} @bound_2; 
	for ($i = 1; $i < @bound_2; $i++)
	{
		print out "domain $i: "; 
		print out $bound_2[$i-1] + 1, " - ", $bound_2[$i], "\n";
	}
}

close(out)
