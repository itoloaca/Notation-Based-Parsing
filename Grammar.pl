
 #!/usr/local/bin/perl

use strict;
use warnings;

use Marpa::R2;
use XML::LibXML;
use Data::Dumper;

my $g = Marpa::R2::Scanless::G->new({
        default_action => '::array',
        source         => \(<<'END_OF_SOURCE'),

:start        ::= Start
Start         ::= mrow
                
expressions   ::= expression
                | expression expressions
  
Error         ::= anything action => Semantics::ThrowError
mrowSTART     ::= '<mrow' notclose '>'
mrowEND       ::= '</mrow>'

mrow          ::= mrowSTART expressions mrowEND 
               || Error
mi          ::= miSTART variable miEND 
               || Error
mo          ::= moSTART operator moEND 
               || Error
msqrt       ::= expression


expression    ::= mrow 
                | mi
                | mo
                | msqrt

variable      ~ [\w]+
operator      ~ [&;\d\w]+
notclose      ~ [^>]+
anything      ~ [^\r]+

END_OF_SOURCE
});

my $re = Marpa::R2::Scanless::R->new({ grammar => $g });
my $doc = XML::LibXML->load_xml(location => 'exampleFormula.xml');
my $xpath_context = XML::LibXML::XPathContext->new($doc->documentElement);
$xpath_context->registerNs('m','http://www.w3.org/1998/Math/MathML');
my ($top_mrow) = $xpath_context->findnodes('//m:mrow');
my $input = $top_mrow->toString(1);

print "Trying to parse:\n";#$input\n\n";
$re->read(\$input);
my $value = ${$re->value};
print "Output:\n".Dumper($value);

package Semantics;
use Data::Dumper;

sub ThrowError {
 print STDERR "Fatal Error in parsing: ",Dumper(\@_);
 exit; }


1;