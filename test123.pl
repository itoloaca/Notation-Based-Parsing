#!/usr/local/bin/perl
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
                      clock_gettime clock_getres clock_nanosleep clock
                      stat lstat );
binmode STDOUT, ':utf8'; #to get rid of "Wide character print at..." warning 

#Initialize grammar#
my $grammar = Marpa::R2::Scanless::G->new( { source => \$My_Grammar::dsl } );
# my $grammar = Marpa::R2::Scanless::G->new( { source => \$dsl } );

my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, semantics_package => 'My_Actions' } );

###########################################################################################
#Get input from file# Input method 1 ####################################################
my $input_file = "input.omdoc";
open( my $input_fh, "<", $input_file ) || die "Can't open $input_file: $!";
my $input1 = join('', <$input_fh>);
$input1 = decode("UTF-8",$input1);

#Choose input 1-file, 2-xml, 3-html
my $input = $input1;
my $temp = $input;
print "$input \n";
#Take away whitespaces around tags
$input =~ s/\s*(<\/?[^<>\s]*(?:\s*[^=<>]+\s*="[^"]*"\s*)*>)\s*/$1/g;
print "Trimmed input: \n$input \n" if ($temp ne $input);
#Feed the input to the grammar#
my $length = length $input;
my $start = 0; #default - zero 
my $pos = $recce->read( \"$input", $start, $length);
my $actual_events = [];

#Record positions where notations matched#######################################122
READ: while (1) {
  my @current_events = ();
  
  EVENT:
  for my $event ( @{ $recce->events() } ) {
    my ($name) = @{$event};
    push @current_events, $name;
  }

  for (@current_events) {
      my ($start_rule, $length_rule) = $recce->last_completed($_);
      my $last_expression = $recce->substring($start_rule, $length_rule);
      push @$actual_events, [$pos - length($last_expression),length($last_expression), $_]; 
  }
  last READ if $pos >= $length;
  eval {$pos = $recce->resume(); };
  last READ if $@;
} ## end READ: while (1)

print "Actual events: ",Dumper($actual_events);
while (my $value = $recce->value()) {
  # print "Value: \n";s
  # p $value;
}
