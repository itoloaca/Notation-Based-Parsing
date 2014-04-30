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
my $dsl = join("\n", @$ref);
print $dsl;



$req = POST 'http://localhost:8081/:marpa/getActions?=';    
$req->header( 'Content-Type' => 'application/json' );
$req->content( '{"a" : "b"}' );

$res = $ua->request($req);

$ref = decode_json($res->decoded_content);
my $actions = join ("\n", @$ref);
print "\n\n" . $actions . "\n";

$actions = "package Actions;\n" . $actions . "\n1;\n";
my $filename = 'actions.pm';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh $actions;
close $fh;
