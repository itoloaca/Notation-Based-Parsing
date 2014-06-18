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
use My_Actions;
#use My_Grammar;
use Encode;
use XML::LibXML;
#POST REQUEST##############################################

require LWP::UserAgent;


my $content = '{"a" : "b"}' ;
my $ua = LWP::UserAgent->new;
my $req = POST 'http://localhost:8081/:marpa/getGrammar?=';    
$req->header( 'Content-Type' => 'application/json', 'Content-Length' => length('{"a" : "b"}'));
$req->content(Encode::encode_utf8($content));
$req->content_type("text/plain; charset='utf8'");



my $res = $ua->request($req);
my $ref = decode_json($res->decoded_content);
my $dsl = "";
foreach (@$ref) {
  $dsl = $dsl . $_ .  "\n";
}


############################################################
############################################################


#Initialize grammar#
#my $grammar = Marpa::R2::Scanless::G->new( { source => \$My_Grammar::dsl } );
my $grammar = Marpa::R2::Scanless::G->new( { source => \$dsl } );
my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, semantics_package => 'My_Actions' } );

#Get input from file# Input method 1
my $input_file = "input.omdoc";
open( my $input_fh, "<", $input_file ) || die "Can't open $input_file: $!";
my $input = join('', <$input_fh>);
$input = decode("UTF-8",$input);

#Harvest input from XML file# Input method 2
# my $dom = XML::LibXML->load_xml(location=>"1311.1412.xhtml"); 
# my $nc = XML::LibXML::XPathContext->new($dom); 
# $nc->registerNs("m","http://www.w3.org/1998/Math/MathML"); 
# my @math_elements = $nc->findnodes("//m:math"); 
# # print scalar(@math_elements),"\n";

# my $input = $math_elements[12];
# foreach (@math_elements) {
#     $input = $input . $_}
# print "\n\n\n";

#Feed the input to the grammar#
my $length = length $input;
my $start = 0; #default - zero 
my $pos = $recce->read( \"$input", $start, $length - $start );
my $actual_events = [];

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
      push @$actual_events, [$pos - length($last_expression) +1,$pos+1, $_];
  }
  last READ if $pos >= $length;
  eval {$pos = $recce->resume(); };
  last READ if $@;
} ## end READ: while (1)

my $value_ref = $recce->value();
if ( not defined $value_ref ) {
  die "No parse\n";
}
my $actual_value = ${$value_ref};
print "Actual value: $actual_value\n";
print "Actual events: ",Dumper($actual_events);


