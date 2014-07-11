# use Test::More;
# use utf8;
# use 5.014;
# use strict;
# use warnings;
# use LWP::UserAgent;
# use HTTP::Request::Common;
# use JSON;
# use Data::Dumper; 
# use English qw( -no_match_vars );
# use Marpa::R2;
# use My_Actions;
# use My_Grammar;
# use Encode;
# use Data::Printer;

# my $ref = {
#             'position' => [
#                             55,
#                             42
#                           ],
#             'argRuleN227A1Arg' => [
#                                   [
#                                     87,
#                                     10
#                                   ]
#                                 ]
#           };

# # print "W " . Compare({
# #             'position' => [
# #                             55,
# #                             42
# #                           ],
# #             'argRuleN227A1Arg' => [
# #                                   [
# #                                     87,
# #                                     10
# #                                   ]
# #                                 ]
# #           }, {
# #             'position' => [
# #                             55,
# #                             42
# #                           ],
# #             'argRuleN227A1Arg' => [
# #                                   [
# #                                     87,
# #                                     10
# #                                   ]
# #                                 ]
# #           }) ."\n";

# use Scalar::Util qw(looks_like_number);
# my @test = qw(zzz 456 vc32 xyzt 12.34);

#  # [0] "mnB",
#  #                        [1] 6,
#  #                        [2] 4,
#  #                        [3] [
#  #                            [0] "ws",
#  #                            [1] 6,
#  #                            [2] 0
#  #                        ],
#  #                        [4] "<mn",
#  #                        [5] undef,
#  #                        [6] ">",
#  #                        [7] [
#  #                            [0] "ws",
#  #                            [1] 10,
#  #                            [2] 0
#  #                        ]

#      # /.*N\d+$/

# # sub getNotations {
# # 	my ($rule) = @_;
# # 	my $result = [];
# # 	push @$result, $rule if ($rule->[0] =~ /.*N\d+$/);
# # 	for (my $i = 3; $i < scalar(@$rule); $i++) {
# # 		push @$result, @{getNotations($rule->[$i])} if ref $rule->[$i] eq 'ARRAY';

# # 	} 
# # 	return $result;
# # }


# use Test::More;
# use utf8;
# use 5.014;
# use strict;
# use warnings;
# use LWP::UserAgent;
# use HTTP::Request::Common;
# use JSON;
# use Data::Dumper; 
# use English qw( -no_match_vars );
# use Marpa::R2;
# use My_Actions;
# use My_Grammar;
# use Encode;
# use Data::Printer;
# use Data::Compare;


# my $mn = [ "RuleNameN123", 6,4, ["argRuleN2Seq",6,0], "<mn", ["RuleNameN123",1,2],["AnotherRuleN7",1,2,"a","b","c"],["argRuleN2Seq",11,0,["argRuleN1Arg",1,1]]];
# sub getNotations {
# 	my ($rule) = @_;
# 	my $name = $rule->[0];
# 	my $result = {};
# 	if ($name =~ /.*N\d+$/) {
# 		my $attrib = extractArgs($rule);
# 		$attrib->{"position"} = [$rule->[1],$rule->[2]]; 

# 		push @{$result->{$name}}, $attrib; 
# 	}
# 	for (my $i = 3; $i < scalar(@$rule); $i++) {
# 		if (ref $rule->[$i] eq 'ARRAY') {
# 			my %temp = %{getNotations($rule->[$i])};
# 			while (my ($k, $v) = each(%temp)) {
# 			  	push @{$result->{$k}}, @$v;
# 			}
# 		}

# 	} 
# 	return $result;
# }

# sub extractArgs {
# 	my ($rule) = @_;
# 	my $result = {};
# 	push @{$result->{$rule->[0]}}, [$rule->[1], $rule->[2]] if ($rule->[0] =~ /^argRuleN.*/);
# 	for (my $i = 3; $i < scalar(@$rule); $i++) {
# 	    if (ref $rule->[$i] eq 'ARRAY' &&  $rule->[$i]->[0] !~ /N\d+$/) {
# 			    my %temp = %{extractArgs($rule->[$i])};
# 			  	while (my ($k, $v) = each(%temp)) {
# 			  	push @{$result->{$k}}, @$v;
			  
# 				}
# 	    }
# 	} 
# 	return $result;
# }


# # my $r =  getNotations($mn);

# # print Dumper(\$r);

use utf8;
use strict;
use warnings;
use Mojo::DOM;
use Data::Dumper;
use HTML::Entities;
use Encode;
use HTML::Strip::Whitespace qw(html_strip_whitespace);

open FILEHANDLE, 'html_math_test.html' or die $!;
my $raw_content = do { local $/; <FILEHANDLE> };
# $raw_content = \"<!doctype html> <html>   <msup>   <mi>  x  </mi>   <mn>   7   </mn></msup>  </html>";
my $content = "";
html_strip_whitespace(
    'source' => \$raw_content,
    'out' => \$content
    );
my $dom = Mojo::DOM->new($content);
$dom->xml(0); #enforce html 
my @math = $dom->find('math')->each;
foreach (@math) {
  $_ = $_ -> to_string;
  $_ = decode("UTF-8", encode("UTF-8", $_));
}
 
# print Dumper(\@math);
# foreach (@math){
#   print Dumper(\$_);
#   print $_ . "\n\n";
# }
my $index2 = 7;
my $input3 = $math[$index2];
print "$input3 \n";
print "Nr = ", scalar(@math) , "\n";
# print ($math[62]);
