 #!/usr/local/bin/perl

#POST REQUEST##############################################
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common;
use JSON;

require LWP::UserAgent;
my $ua = LWP::UserAgent->new;
my $req = POST 'http://localhost:8081/:marpa/getGrammar?=';    
$req->header( 'Content-Type' => 'application/json' );
$req->content( '{"a" : "b"}' );

my $res = $ua->request($req);

my $ref = decode_json($res->decoded_content);
my $dsl = "";
foreach (@$ref) {
	$dsl = $dsl . $_ . "\n";
}

print $dsl;

############################################################

use Marpa::R2;
use My_Actions;
use My_Grammar;

#Initialize grammar#
my $grammar = Marpa::R2::Scanless::G->new( { source => \$My_Grammar::dsl } );
#my $grammar = Marpa::R2::Scanless::G->new( { source => \$dsl } );
my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, semantics_package => 'My_Actions' } );

#Get input from file#
my $input_file = "input.omdoc";
open( my $input_fh, "<", $input_file ) || die "Can't open $input_file: $!";
my $input = join('', <$input_fh>);
#print "Grammar input:\n" . $input . "\n";

#Feed the input to the grammar#
$recce->read( \$input );

#Print result#
my $value_ref = $recce->value;
my $value = $value_ref ? ${$value_ref} : 'No Parse';

print "Parse result:\n". $value . "\n\n";

