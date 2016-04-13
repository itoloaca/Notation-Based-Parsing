
# Sending POST from command-line:
# curl -d 'foo' localhost:3000/initialize_grammar

# Lite app:

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
use URI::Escape;

my $dsl;
my $grammar;
my $flag = 1;
my $global_input = "";
my $grammar_init = 0;

sub encodeAllURIComponents {
    my ($str) = @_;
    my @chars = split //, $str;
    @chars = map { encodeURIComponent($_) } @chars; 
    return join('', @chars);
}


sub decodeAllURIComponents {
    my ($str) = @_;
    return uri_unescape($str);
}

sub initialize_grammar {
  if ($flag) {
    $flag = 0;
    # my $post_params = $self->req->body_params->pairs || [];
    my $content = '{"a" : "b"}' ;
    my $ua = LWP::UserAgent->new;
    my $req = POST 'http://localhost:8081/:marpa/getGrammar?=';    
    $req->header( 'Content-Type' => 'application/json', 'Content-Length' => length('{"a" : "b"}'));
    $req->content(Encode::encode_utf8($content));
    $req->content_type("text/plain; charset='utf8'");
    my $res = $ua->request($req);
    my $ref = decode_json($res->decoded_content);
    $dsl = "";
    foreach (@$ref) {
      $dsl = $dsl . $_ .  "\n";
    }
    $grammar = Marpa::R2::Scanless::G->new( { bless_package => 'Notation', source => \$dsl } );
    # p $dsl;
  }
};

post '/detect_notations' => sub {
  initialize_grammar;
  my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, 
      semantics_package => 'My_Actions',
      max_parses => 300 } );                           # VERY IMPORTANT - LIMITS THE TOTAL NUMBER OF PROCESSED PARSE TREES
  my $self = shift;
  my @post_params = $self->req->body_params->pairs || [];
  print "POST PARAMS = \n";
  p @post_params;
  print "\nEND_POST_PARAMS\n";
  my $post_data = $post_params[0][0];
  
  my $input = $post_data;

  my $temp = $input;
  print "\$input =$ input \n";
  #Take away whitespaces around tags
  $input =~ s/\s*(<\/?[^<>\s]*(?:\s*[^=<>]+\s*="[^"]*"\s*)*>)\s*/$1/g;

  $global_input = $input; #SAVE INPUT FOR GET ARGUMENTS QUERY
  print "Trimmed input: \n$input \n" if ($temp ne $input);
  #Feed the input to the grammar#
  my $length = length $input;
  print "Length of input: $length \n";
  my $start = 0; #default - zero
  my $pos = $recce->read( \"$input", $start, $length);
  print "recce->read completed\n";
  my $end = $start + $length;
  my $index = 0;
  RESUME: while ($pos < $end) { 
    $index = $index + 1;
    last RESUME if $index > 3000; # VERY IMPORTANT - LIMITS THE TOTAL NUMBER OF ITERATIONS TO AVOID INFINITE LOOPING
    eval { $pos = $recce->resume(); }; 
  }
  print "recce->resume completed\n";
  my $payload = {};
  my $counter = 0;
  my $valueList = ();
  my $value_ref = \'is defined';
  my $t0 = [gettimeofday];

  PROCESS: while (defined $value_ref) {
    $counter++;
    $value_ref = $recce->value();
    if (defined $value_ref) {
      my $actual_value = ${$value_ref};

      my $notations = getNotations($actual_value);

      if (%$notations) {
        while (my ($k, $values) = each %$notations) {
          foreach(@$values){
              my $v = $_;
              my $flag = 0;
              foreach (@{$payload->{$k}}) {
                $flag = 1 if (Compare($_, $v) == 1);
              }
              push @{$payload->{$k}}, $v if $flag == 0;
          }
        }  
      }
    }
  }
  print "PAYLOAD\n";
  p $payload;
  my $final = {"status" => "OK",
               "payload" => $payload,
               "message" => encodeURIComponent($input)  };
  my $json = encode_json $final;
  # my$str={"status":"OK","payload":[],"message":"No obvious problems."}
  $self->res->headers->header('Access-Control-Allow-Origin' => '*');
  $self->render(text=> $json);
};

#FUNCTION FOR NOTATION/ARGUMENT PROCESSING ############################
sub getNotations {
  my ($rule) = @_;
  my $name = $rule->[0];
  my $result = {};
  if ($name =~ /N\d+$/) {
    my $attrib = extractArgs($rule);
    my $str = encodeURIComponent(substr($global_input, $rule->[1], $rule->[2]));
   
    $attrib->{"position"} = [[$rule->[1],$rule->[2], $str]]; 

    push @{$result->{$name}}, $attrib; 
  }
  for (my $i = 3; $i < scalar(@$rule); $i++) {
    if (ref $rule->[$i] eq 'ARRAY') {
      my %temp = %{getNotations($rule->[$i])};
      while (my ($k, $v) = each(%temp)) {
          push @{$result->{$k}}, @$v;
      }
    }
  } 
  return $result;
}

sub extractArgs {
  my ($rule) = @_;
  my $result = {};
  push @{$result->{$rule->[0]}}, [$rule->[1], $rule->[2], encodeURIComponent(substr($global_input, $rule->[1], $rule->[2]))] if ($rule->[0] =~ /^argRuleN.*/);
  for (my $i = 3; $i < scalar(@$rule); $i++) {
      if (ref $rule->[$i] eq 'ARRAY' &&  $rule->[$i]->[0] !~ /N\d+$/) {
          my %temp = %{extractArgs($rule->[$i])};
          while (my ($k, $v) = each(%temp)) {
          push @{$result->{$k}}, @$v;
        }
      }
  } 
  return $result;
}

app->start;