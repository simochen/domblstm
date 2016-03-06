#!/usr/bin/perl

$sdir = "chenxiao@202.120.1.118:/home/chenxiao/dataset/multi";
$ldir = "/home/simochen/Prog/genTest/multi/";
for($i=1; $i<=1; $i++){
	$sfile = (join "/", $sdir, $i).".txt"; 
	`pscp -P 7930 $sfile $ldir`;
}
