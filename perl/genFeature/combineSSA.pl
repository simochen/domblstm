#!/usr/bin/perl

#combine SS and SA features
#USAGE combineSSA.pl profix sstype satype

$profix = $ARGV[0];
$sstype = $ARGV[1];
$satype = $ARGV[2];

$ssfile = (join "_", $profix, $sstype).".txt";
$safile = (join "_", $profix, $satype).".txt";

$outF = $profix."_".$sstype.$satype.".txt";
open(ss, "<$ssfile");
@ssFi = <ss>;
close(ss);
open(sa, "<$safile");
@saFi = <sa>;
close(sa);
open(fea, ">$outF");
$ssF = shift(@ssFi);
chomp($ssF);
while($ssF){
	$saF = shift(@saFi); 
	print fea $ssF." ".$saF;
	$ssF = shift(@ssFi);
	chomp($ssF);
}
close(fea);
