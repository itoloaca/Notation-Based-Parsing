
#!/usr/local/bin/perl
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



# Marpa Server Plugin : using the Marpa Grammar to parse MathML for notations
#----------------------------------------------------------------------------
# Toloaca Ion   <i.toloaca@jacobs-university.de>
#----------------------------------------------------------------------------
#   Purpose of the code: 
# A post request is used to fetch the Marpa Grammar created in Scala from MMT
# notations. Then the Grammar is passed to Marpa and the positions where the 
# notations matched are recorded.
#----------------------------------------------------------------------------


#POST REQUEST##############################################

require LWP::UserAgent;


my $content = '{"a" : "b"}' ;
my $ua = LWP::UserAgent->new;
my $req = POST 'http://localhost:8081/:marpa/getGrammar?=';    
isa_ok($req, 'HTTP::Request');   #TYPECHECK
$req->header( 'Content-Type' => 'application/json', 'Content-Length' => length('{"a" : "b"}'));
$req->content(Encode::encode_utf8($content));
$req->content_type("text/plain; charset='utf8'");


my $res = $ua->request($req);
my $ref = decode_json($res->decoded_content);
my $dsl = "";
foreach (@$ref) {
  $dsl = $dsl . $_ .  "\n";
}

#isnt($dsl, "", "$dsl not empty");  #CHECK WHETHER THE GRAMMAR RECEIVED IS NOT EMPTY

############################################################
############################################################


#Initialize grammar#
my $grammar = Marpa::R2::Scanless::G->new( { source => \$My_Grammar::dsl } );
#my $grammar = Marpa::R2::Scanless::G->new( { source => \$dsl } );
my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, semantics_package => 'My_Actions' } );

isa_ok($grammar, 'Marpa::R2::Scanless::G'); #CHECKING TYPES
isa_ok($recce, 'Marpa::R2::Scanless::R');

###########################################################################################
#Get input from file# Input method 1 ####################################################
my $input_file = "input.omdoc";
open( my $input_fh, "<", $input_file ) || die "Can't open $input_file: $!";
my $input = join('', <$input_fh>);
$input = decode("UTF-8",$input);
isnt($input,"",'Input not empty'); 
print ($input . "\n");
#Feed the input to the grammar#
my $length = length $input;
my $start = 0; #default - zero 
my $pos = $recce->read( \"$input", $start, $length - $start );
my $actual_events = [];

#Record positions where notations matched#
READ: while (1) {
 
  my @current_events = ();
  
  EVENT:
  for my $event ( @{ $recce->events() } ) {
    my ($name) = @{$event};
    push @current_events, $name;
  }

  for (@current_events) {
      my $suf =  substr $_, (length $_) - 2, 2;  
      my $name = "";
      if ($suf eq "_P" || $suf eq "_C") {
        $name = substr $_,0,-2;
      } else {
        $name = $_;
      }

      my ($start_rule, $length_rule) = $recce->last_completed($name);
      my $last_expression = $recce->substring($start_rule, $length_rule);
      push @$actual_events, [$pos - length($last_expression) +1,$pos+1, $_];
  }
  last READ if $pos >= $length;
  eval {$pos = $recce->resume(); };
  last READ if $@;
} ## end READ: while (1)

my $value_ref = $recce->value();

ok(defined $value_ref, 'value_ref defined');
# isnt($actual_events,[],'Event list not empty');

if ( not defined $value_ref ) {
  die "No parse\n";
}

my $actual_value = ${$value_ref};
print "Actual events: ",Dumper($actual_events);
print "Actual value:",Dumper($actual_value),"\n";


my $value_ref = $recce->value();
print "Actual value:",Dumper($actual_value),"\n";

done_testing();