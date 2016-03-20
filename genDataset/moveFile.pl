#!/usr/bin/perl

$multiList = "/home/chenxiao/domainDS/m_multi.list";
$discList = "/home/chenxiao/domainDS/m_disc.list";

$multidir = "/home/chenxiao/domainDS/cullpdb/multi";
$discdir = "/home/chenxiao/domainDS/cullpdb/disc";

open(mlist, "<$multiList");
@mlist = <mlist>;
close(mlist);

open(dlist, "<$discList");
@dlist = <dlist>;
close(dlist);

`rm -r $discdir`;
`mkdir $discdir`;

$cnt = 0;
while($line = shift(@dlist)){
	chomp($line);
	$cnt++;
	$orifasta = (join "/", $multidir, $line).".fasta";
	$oripssm = (join "/", $multidir, $line).".pssm";
	$tarfasta = (join "/", $discdir, $cnt).".fasta";
	$tarpssm = (join "/", $discdir, $cnt).".pssm";
	`mv $orifasta $tarfasta`;
	if($line <= 500){
		`mv $oripssm $tarpssm`;
	}
}

$cnt = 0;
while($line = shift(@mlist)){
	chomp($line);
	$cnt++;
	$orifasta = (join "/", $multidir, $line).".fasta";
	$oripssm = (join "/", $multidir, $line).".pssm";
	$tarfasta = (join "/", $multidir, $cnt).".fasta";
	$tarpssm = (join "/", $multidir, $cnt).".pssm";
	`mv $orifasta $tarfasta`;
	if($line <= 500){
		`mv $oripssm $tarpssm`;
	}
}