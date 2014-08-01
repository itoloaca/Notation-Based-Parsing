#!/usr/local/bin/perl
use utf8;
use strict;
use warnings;
use Mojo::DOM;
use Data::Dumper;
use HTML::Entities;
use Encode;
# use HTML::Strip::Whitespace qw(html_strip_whitespace);

open FILEHANDLE, 'html_math_test.html' or die $!;
my $content = do { local $/; <FILEHANDLE> };
# my $content = "";
# html_strip_whitespace(
#     'source' => \$raw_content,
#     'out' => \$content
#     );
my $dom = Mojo::DOM->new($content);
$dom->xml(0); #enforce html 
my @math = $dom->find('math')->each;
foreach (@math) {
	$_ = $_ -> to_string;
	$_ = decode("UTF-8", encode("UTF-8", $_));
}
 
# print Dumper(\@math);
# foreach (@math){
# 	print Dumper(\$_);
# 	print $_ . "\n\n";
# }
my $index2 = 29;
my $input3 = $math[$index2];
$input3 =~ s/\s*(<\/?[^<>\s]*(?:\s*[^=<>]+\s*="[^"]*"\s*)*>)\s*/$1/g;
print "$input3 \n";
print "Nr = ", scalar(@math) , "\n";
# print ($math[62]);
#    \s*(</?[^<>\s]*(?:\s*[^=<>]+\s*="[^"]*"\s*)*>)\s*