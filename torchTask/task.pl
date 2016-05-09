#!/usr/bin/perl

@opt = ([1,72],
		[1,102],
		[2,56],
		[2,86],
		[3,85],
		[3,115],
		[4,184],
		[4,214],
		[5,167],
		[5,217]); 
for $i (0 .. $#opt ){
	$cmd = "cd ../bin/; th postprocess.lua -savepath 'r20' -cv $opt[$i][0] -epoch $opt[$i][1]";
	`$cmd`;
	print "multi is done\n";
	
	for($j = 1; $j <=5; $j++){
		$cmdline = $cmd." -type 'single' -sg $j";
		`$cmdline`;
		print "single with sg $j is done\n";
	}
	print "done with cv $opt[$i][0] and epoch $opt[$i][1]\n";
}