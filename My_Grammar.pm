package My_Grammar;

our $dsl = <<'END_OF_DSL';
:default ::= action => getString
lexeme default = latm => 1
Error ::= anyToken  
     || anyToken Error  
:lexeme ~ <anyToken> priority => -1
:start ::= Start
Start ::= Notation  
         ||Error  action => do_printAny
Any ::= zeroPriorityAnyToken 
     || zeroPriorityAnyToken Any
zeroPriorityAnyToken ~ [\s\S]
Expression  ::= '<' Any '>' 
moB ~ '<m:mo>'
moE ~ '</m:mo>'
rowB ~ '<m:mrow>'
rowE ~ '</m:mrow>'
# :lexeme ~ <rowB> pause => before event => 'before rule\n'
# :lexeme ~ <rowE> pause => after event => 'after rule\n'
anyToken ~ [\s\S]
Notation ::= _equal_notequal___
| _equal_notequal__
| _equal_eq___
| _equal_eq__
| _equal_notequal_
| _equal_notequal
| _equal_eq_
| _equal_eq
rule5::= moB ')' moE 
rule1::= moB '(' moE 
_equal_notequal___::= rowB rule6 rowE 
_equal_eq_::= rowB rule2 rowE 
_equal_eq___::= rowB rule2 rowE 
_equal_notequal__::= rowB rule1 rule3 rule6 rule7 rule5 rowE 
_equal_eq__::= rowB rule1 rule4 rule5 rowE
rule4::= Expression 
| rule4 rule2 Expression
rule3::= Expression
_equal_notequal::= rowB rule1 rule3 rule6 rule7 rule5 rowE
rule2::= moB '=' moE 
_equal_eq::= rowB rule1 rule4 rule5 rowE
_equal_notequal_::= rowB rule6 rowE
rule7::= Expression
rule6::= moB '≠' moE
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
