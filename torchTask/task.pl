#!/usr/bin/perl

@opt = (
		#[1,90],
		#[1,140],
		#[2,56],
		#[2,86],
		#[3,215],
		#[3,297],
		#[4,184],
		#[4,214],
		[5,255],
		[5,312]
		); 
for $i (0 .. $#opt ){
	$cmd = "cd ../bin/; th postprocess.lua -savepath 'r20_mot0.2' -cv $opt[$i][0] -epoch $opt[$i][1]";
	`$cmd`;
	print "multi is done\n";
	
	for($j = 1; $j <=5; $j++){
		$cmdline = $cmd." -type 'single' -sg $j";
		`$cmdline`;
		print "single with sg $j is done\n";
	}
	print "done with cv $opt[$i][0] and epoch $opt[$i][1]\n";
}