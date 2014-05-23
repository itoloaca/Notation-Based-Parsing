package My_Grammar;
our $dsl = <<END_OF_DSL;
:start ::= Start
:default ::= action => do_print
Start ::= Rule1 
Rule1 ::= '<mrow><mo>=</mo><mo>=</mo><mo>≠</mo></mrow>'
event 'Start' = completed Start 
END_OF_DSL
1;


# Expression ::=
# 	Notation  ::first

# Notation ::= 
#       Rule1  ::first
# Rule1 ::= 
# 	Rule2  ::first
# 	| Rule1 '+' Rule1  do_add
# Rule2 ::= 
# 	Number  ::first
#    | Rule2 '*' Rule2  do_multiply
