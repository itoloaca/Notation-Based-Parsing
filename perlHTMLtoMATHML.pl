#!/usr/local/bin/perl
use utf8;
use strict;
use warnings;
use Mojo::DOM;
use Data::Dumper;

open FILEHANDLE, 'html_math_test.html' or die $!;
my $content = do { local $/; <FILEHANDLE> };
my $dom = Mojo::DOM->new($content);
# $dom->xml(0); #enforce html 
my @math = $dom->find("math")->each;
#print scalar(@math) . "\n";
print $math[2];