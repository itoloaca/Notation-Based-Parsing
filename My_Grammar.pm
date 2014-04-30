package My_Grammar;

our $dsl = <<'END_OF_DSL';
:default ::= action => do_print
lexeme default = latm => 1

:start ::= Script 
Script ::= Number comma Number action => do_printNr 
		  || Any 
          

Any ::= anyToken action => do_printAny
       | anyToken Any action => do_printAny
anyToken ~ [\s\S]
comma ~ [',']
:lexeme ~ comma priority => 10
:lexeme ~ <anyToken> priority => -10
:lexeme ~ Number priority => 10 
Number ~ digits
digits ~ [\d]+
:discard ~ whitespace
whitespace ~ [\s]+

END_OF_DSL


1;


# Expression ::=
# 	Notation action => ::first

# Notation ::= 
#       Rule1 action => ::first
# Rule1 ::= 
# 	Rule2 action => ::first
# 	| Rule1 '+' Rule1 action => do_add
# Rule2 ::= 
# 	Number action => ::first
#    | Rule2 '*' Rule2 action => do_multiply
