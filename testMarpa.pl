 #!/usr/local/bin/perl

use Marpa::R2;
use My_Actions;
use My_Grammar;

#Initialize grammar#
my $grammar = Marpa::R2::Scanless::G->new( { source => \$My_Grammar::dsl } );
my $recce = Marpa::R2::Scanless::R->new(
    { grammar => $grammar, 
    	# ranking_method => "highest_rule_only",
    	semantics_package => 'My_Actions' } );

#Get input from file#
my $input_file = "input.omdoc";
open( my $input_fh, "<", $input_file ) || die "Can't open $input_file: $!";
my $input = join('', <$input_fh>);
print "Grammar input:\n" . $input . "\n";

#Feed the input to the grammar#
$recce->read( \$input );

#Print result#
my $value_ref = $recce->value;
my $value = $value_ref ? ${$value_ref} : 'No Parse';

print "Parse result:\n". $value . "\n\n";


