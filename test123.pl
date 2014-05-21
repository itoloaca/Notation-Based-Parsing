#!/usr/local/bin/perl
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

my @current = ("predicted_123","predicted_2", "3");
my $actual_events = [];
my %predicted = ();
my $pos = 7;

for (@current) {
	if (!/^predicted_/) { 
		push @$actual_events, [$predicted{$_},$pos, $_];
		delete $predicted{$_};
	}
}
for (@current) {
	if (/^predicted_/) {
		s/^predicted_//;
		if (!defined($predicted{$_})) {
			$predicted{$_} = $pos;
		}
	}
}

print "\n".Dumper($actual_events);
print Dumper(%predicted);