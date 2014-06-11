 #!/usr/local/bin/perl

use Marpa::R2;
use My_Actions;
use My_Grammar;

#Initialize grammar#
my $grammar = Marpa::R2::Scanless::G->new( { source => \$My_Grammar::dsl } );
my $re = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, 	
    	# ranking_method => "highest_rule_only",
    	semantics_package =>  'My_Actions'} );

#Get input from file#
my $input_file = "input.omdoc";
open( my $input_fh, "<", $input_file ) || die "Can't open $input_file: $!";
my $input = join('', <$input_fh>);
print "Grammar input:\n" . $input . "\n";

# #Feed the input to the grammar#
# $re->read( \$input );

# #Print result#
# my $value_ref = $re->value;
# my $value = $value_ref ? ${$value_ref} : 'No Parse';

# print "Parse result:\n". $value . "\n\n";

my $string = $input;
my $length = length $string;
for (
    my $pos = $re->read( \$string);
    $pos < $length;
    $pos = $re->resume()
    )
{
	print "HERE";
    my ( $start, $length ) = $re->pause_span();
    my $value = substr $string, $start + 1, $length - 2;
    $value = decode_string($value) if -1 != index $value, '\\';
    $re->lexeme_read( 'lstring', $start, $length, $value ) // die;
} ## end for ( my $pos = $re->read( \$string ); $pos < $length...)
my $per_parse_arg = bless {}, 'MarpaX::JSON::Actions';
my $value_ref = $re->value($per_parse_arg);
print "\nResult = " . ${$value_ref};