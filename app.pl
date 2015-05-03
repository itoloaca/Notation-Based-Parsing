
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
                      clock_gettime clock_getres clock_nanosleep clock
                      stat lstat );
binmode STDOUT, ':utf8'; #to get rid of "Wide character print at..." warning 
use Mojolicious::Lite;
require LWP::UserAgent;

my $dsl;
my $grammar;
my $flag = 1;
post '/initialize_grammar' => sub {
  my $self = shift;
  if ($flag) {
    $flag = 0;
    my $post_params = $self->req->body_params->params || [];
    # while (my ($key,$value) = splice(@$post_params,0,2)) {
    #   if ($key eq 'rule') {
    #     create_rule($value);
    #   }
    # }
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
  $self->render(text=>'success');
};

post '/detect_notations' => sub {

  my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, semantics_package => 'My_Actions' } );
  my $self = shift;
  my @post_params = $self->req->body_params->params || [];
  print "POST PARAMS = \n";
  p @post_params;
  print "\nEND_POST_PARAMS\n";
  my $post_data = $post_params[0][1];
  # #Input from XML
  # use Mojo::DOM;
  # open FILEHANDLE, 'html_math_test.html' or die $!;
  # my $content1 = do { local $/; <FILEHANDLE> };
  # my $dom1 = Mojo::DOM->new($content1);
  # $dom1->xml(0); #enforce html 
  # my @math = $dom1->find('math')->each;
  # foreach (@math) {
  #   $_ = $_ -> to_string;
  #   $_ = decode("UTF-8", encode("UTF-8", $_));
  # }
  # my $index2 = 73;
  # my $input3 = $math[$index2];
  # ###################################################################################################
  # #Choose input 1-file, 2-xml, 3-html
  # print "\nInput3\n$input3\nEND\n";
  my $input = $post_data;
  # my $input = $input3; 
  my $temp = $input;
  print "\$input =$ input \n";
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
        push @$actual_events, [$pos - length($last_expression),length($last_expression), $_] if ($_ !~ /^argRuleN.*/);
    }
    last READ if $pos >= $length;
    eval {$pos = $recce->resume(); };
    last READ if $@;
  } ## end READ: while (1)

  print "Actual events: ",Dumper($actual_events);

  # #GET ARGUMENT POSITIONS###################################################################################
  my $result = {};
  for (my $i = 0; $i < scalar(@$actual_events); $i++) {
   
    # print " ####################".$$actual_events[$i]->[2]." ###################\n";
      my ($start, $length, $name)= @{$$actual_events[$i]};
      my $end = $start + $length;
       
      my $recce = Marpa::R2::Scanless::R->new({ grammar => $grammar, semantics_package => 'My_Actions' } )  ;
      my $pos = $recce->read(\"$input", $start, $length);
      
      while ($pos< $end) {
         eval {$pos = $recce->resume(); };
      }
     
      my $counter = 0;
      my $valueList = ();
      my $value_ref = \'is defined';
      my $t0 = [gettimeofday];#
      PROCESS: while (defined $value_ref) {
        $counter++;
        last PROCESS if $counter>50;  #BEST VALUE TO BE DETERMINED
        # print "$counter\n";
        $value_ref = $recce->value();
        if (defined $value_ref) {
          my $actual_value = ${$value_ref};
  
           # print "Actual value $counter:", Dumper(\$actual_value),"\n";
            # p @$actual_value;
            # print $$actual_events[$i]->[2]; 
         # p $actual_value if $i==0;
         
          my $notations = getNotations($actual_value);

          if (%$notations) {
            foreach (@{$notations->{$name}}) {
              my $el = $_;
              # my $s = $notations->{$name}->[0]->{'position'}->[0];
              # my $l = $notations->{$name}->[0]->{'position'}->[1];
              my $s = $el->{'position'}->[0]->[0];
              my $l = $el->{'position'}->[0]->[1];
              my $flag = 0;
              if ($s ==   $start && $l ==  $length) {
                  foreach (@{$result->{$name}}) {
                    $flag = 1 if (Compare($_,$el)==1); }
                  push @{$result->{$name}}, $_ if ($flag == 0);
              }
            }
          }
        }
      }
  }

  print Dumper(\$result);
  
  my $final = {"status" => "OK",
               "payload" => $result,
               "message" => $input};
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
  my $json = encode_json $final;
  # my$str={"status":"OK","payload":[],"message":"No obvious problems."}
  $self->render(text=> $json);
};

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
  push @{$result->{$rule->[0]}}, [$rule->[1], $rule->[2]] if ($rule->[0] =~ /^argRuleN.*/);
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