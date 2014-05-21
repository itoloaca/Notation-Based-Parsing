package My_Grammar;

our $dsl = <<'END_OF_DSL';
:default ::= action => getString
lexeme default = latm => 1
:start ::= Start 
Start ::= '<m:mrow>' ExpressionList '</m:mrow>' 
ExpressionList ::= Expression ExpressionList 
| Expression 
Expression ::= Notation 
 || Presentation 
Presentation ::= '<m:mrow>' ExpressionList '</m:mrow>'
 | '<m:mo>' Expression '</m:mo>' 
 | '<m:mi>' Expression '</m:mi>' 
moB ~ '<m:mo>'
moE ~ '</m:mo>'
Notation ::= _equal_notequal_
| _equal_notequal
| _equal_eq_
| _equal_eq
rule5::= moB ')' moE
rule1::= moB '(' moE
rule7::= moB '≠' moE
_equal_notequal::= rule1 rule6 rule7 rule8 rule5
rule8::= Expression
rule6::= Expression
rule4::= rule3 | rule4 rule2 rule3
rule3::= Expression
_equal_eq::= rule1 rule4 rule5
rule2::= moB '=' moE
_equal_notequal_::= rule7
_equal_eq_::= rule2
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
