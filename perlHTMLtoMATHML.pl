#!/usr/local/bin/perl
use utf8;
use strict;
use warnings;
use Mojo::DOM;
use Data::Dumper;
use HTML::Entities;
use Encode;

open FILEHANDLE, 'html_math_test.html' or die $!;
my $content = do { local $/; <FILEHANDLE> };
my $dom = Mojo::DOM->new($content);
$dom->xml(0); #enforce html 
my @math = $dom->find('math')->each;
foreach (@math) {
	$_ = $_ -> to_string;
	$_ = decode("UTF-8", $_);
}
 

foreach (@math){
	print Dumper(\$_);
	print $_ . "\n\n";
}

print scalar(@math) . "\n";
