use utf8;
use 5.014;
# use strict;
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
use Data::Printer;
use Data::Compare;
use Time::HiRes qw( usleep ualarm gettimeofday tv_interval nanosleep
                        clock stat  );
binmode STDOUT, ':utf8'; #to get rid of "Wide character print at..." warning 
use Mojolicious::Lite;
require LWP::UserAgent;
use URI::Escape::XS;

my $dsl;
my $grammar;
my $flag = 1;

sub encodeAllURIComponents {
    my ($str) = @_;
    my @chars = split //, $str;
    @chars = map {$_ = encodeURIComponent($_); } @chars; 
    return join('', @chars);
}


sub decodeAllURIComponents {
    my ($str) = @_;
    my @chars = split //, $str;
    @chars = map {$_ = decodeURIComponent($_); } @chars; 
    # return join('', @chars);
    return uri_unescape($str);
}
print uri_escape("abcde+%") . "\n";
print decodeAllURIComponents("abcde%2B%25") . "\n";