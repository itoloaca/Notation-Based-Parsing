
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
    { grammar => $grammar, semantics_package => 'My_Actions' } );
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
  my $actual_events = {};

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
        # push @$actual_events, [$pos - length($last_expression),length($last_expression), $_] if ($_ !~ /^argRuleN.*/);
        if ($_ !~ /^argRuleN.*/) {
          my $str = encodeURIComponent(substr($global_input, $pos - length($last_expression), length($last_expression)));
          push @{$actual_events->{$_}}, [$pos - length($last_expression), length($last_expression), $str];
        }
    }
    last READ if $pos >= $length;
    eval {$pos = $recce->resume(); };
    last READ if $@;
  } ## end READ: while (1)

  print "Actual events: ",Dumper($actual_events);
  my $final = {"status" => "OK",
               "payload" => $actual_events,
               "message" => encodeURIComponent($input)  };
  my $json = encode_json $final;
  # my$str={"status":"OK","payload":[],"message":"No obvious problems."}
  $self->res->headers->header('Access-Control-Allow-Origin' => '*');
  $self->render(text=> $json);
};

post '/get_arguments' => sub {
  my $self = shift;
  my @post_params = $self->req->body_params->pairs || [];
  print "POST PARAMS = \n";
  p @post_params;
  print "\nEND_POST_PARAMS\n";
  # my $input = $post_params[0][1];
  my $input = $global_input;

  p $input;
  # my $input = $input3; 
  my $temp = $input;
  #print "\$input =$ input \n";
  #Take away whitespaces around tags
  $input =~ s/\s*(<\/?[^<>\s]*(?:\s*[^=<>]+\s*="[^"]*"\s*)*>)\s*/$1/g;
  print "Trimmed input: \n$input \n";
  p $input;
  my $input_len = length $input;
  print "Length of input: $input_len \n";
  
  ## GET ARGUMENT POSITIONS
  my $name = $post_params[0][3];
  my $start = $post_params[0][5];
  my $length = $post_params[0][7];
  
  my $result = {};
  my $end = $start + $length;
   
  my $recce = Marpa::R2::Scanless::R->new({ grammar => $grammar, semantics_package => 'My_Actions' } )  ;
  my $pos = $recce->read(\"$input", $start, $length);
  
  while ($pos < $end) {
     eval { $pos = $recce->resume(); };
  }

  my $counter = 0;
  my $valueList = ();
  my $value_ref = \'is defined';
  my $t0 = [gettimeofday];#
  PROCESS: while (defined $value_ref) {
    $counter++;
    last PROCESS if $counter>100;  #BEST VALUE TO BE DETERMINED
    $value_ref = $recce->value();
    if (defined $value_ref) {
      my $actual_value = ${$value_ref};

      my $notations = getNotations($actual_value);
      p $notations;
      if (%$notations) {   
        foreach (@{$notations->{$name}}) { 
          my $el = $_;
          my $s = $el->{'position'}->[0]->[0];
          my $l = $el->{'position'}->[0]->[1];
          my $flag = 0;
          if ($s ==   $start && $l ==  $length) {
              foreach (@{$result->{$name}}) {
                $flag = 1 if (Compare($_,$el)==1); 
              }
              push @{$result->{$name}}, $_ if ($flag == 0);
          }
        }
      }
    }
  }
  #Print results of /get_arguments
  print "Get_arguments:";
  p $result;
  my $final = {"status" => "OK",
               "payload" => $result->{$name},
               "key" => $name,
               "message" => encodeURIComponent($input) };
  my $json = encode_json $final;
  #my $str={"status":"OK","payload":[],"message":"No obvious problems."}
  $self->res->headers->header('Access-Control-Allow-Origin' => '*');
  $self->render(text=> $json);
};

#FUNCTION FOR NOTATION/ARGUMENT PROCESSING
sub getNotations {
  my ($rule) = @_;
  my $name = $rule->[0];
  my $result = {};
  if ($name =~ /N\d+$/) {
    my $attrib = extractArgs($rule);
    $attrib->{"position"} = [[$rule->[1],$rule->[2]]]; 

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

# my $final = {"status" => "OK",
#              "payload" =>  
#              {
#                          '_pair_twodimN600' => [
#                                                {
#                                                  'position' => [
#                                                                  [
#                                                                    49,
#                                                                    33
#                                                                  ]
#                                                                ],
#                                                  'argRuleN600A1Arg' => [
#                                                                        [
#                                                                          55,
#                                                                          10
#                                                                        ]
#                                                                      ]
#                                                }
#                                              ]
#             },
#              "message" => "No obvious problems"};
