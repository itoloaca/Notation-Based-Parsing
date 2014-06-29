use Test::More;
use utf8;
use 5.014;
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common;
use JSON;
use Data::Dumper; 
use English qw( -no_match_vars );
use Marpa::R2;
use My_Actions;
use My_Grammar;
use Encode;

 my @myNames = ('Larry', 'Curly');
 my @moreNames = ('Moe', 'Shemp');
 push(@myNames, @moreNames); 
 print Dumper(\@myNames);