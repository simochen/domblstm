#!/usr/bin/perl

$file = "./test.txt";
$file2 = "./test_2.txt";
open(out, ">$file");
print out "1 0 0 \n";
print out "0 1 0 \n";
print out "0 0 1 \n";
close(out);
open(in, "<$file");
open(out, "+>$file2");
while(<in>){
	chomp;
	print out $_."1 \n"
}
close(in,out);
`rm $file`;
