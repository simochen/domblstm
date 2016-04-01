#!/usr/bin/perl

$combdir = "/home/chenxiao/domainDS/cullpdb/mul_dis_seg";

$multiList = "/home/chenxiao/domainDS/m_multi.list";
$discList = "/home/chenxiao/domainDS/m_disc.list";

$multidir = "/home/chenxiao/domainDS/cullpdb/multi_sa";
$discdir = "/home/chenxiao/domainDS/cullpdb/disc_sa";

open(mlist, "<$multiList");
@mlist = <mlist>;
close(mlist);

open(dlist, "<$discList");
@dlist = <dlist>;
close(dlist);

$cnt = 0;
while($line = shift(@dlist)){
	chomp($line);
	$cnt++;
	$oriss = (join "/", $combdir, $line)."_ss.txt";
	$oriacc = (join "/", $combdir, $line)."_acc.txt";
	$oricob = (join "/", $combdir, $line)."_ssacc.txt";
	$tarss = (join "/", $discdir, $cnt)."_ss.txt";
	$taracc = (join "/", $discdir, $cnt)."_acc.txt";
	$tarcob = (join "/", $discdir, $cnt)."_ssacc.txt";
	`mv $oriss $tarss`;
	`mv $oriacc $taracc`;
	`mv $oricob $tarcob`;
}

$cnt = 0;
while($line = shift(@mlist)){
	chomp($line);
	$cnt++;
	$oriss = (join "/", $combdir, $line)."_ss.txt";
	$oriacc = (join "/", $combdir, $line)."_acc.txt";
	$oricob = (join "/", $combdir, $line)."_ssacc.txt";
	$tarss = (join "/", $multidir, $cnt)."_ss.txt";
	$taracc = (join "/", $multidir, $cnt)."_acc.txt";
	$tarcob = (join "/", $multidir, $cnt)."_ssacc.txt";
	`mv $oriss $tarss`;
	`mv $oriacc $taracc`;
	`mv $oricob $tarcob`;
}