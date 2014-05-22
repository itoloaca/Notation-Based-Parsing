package My_Grammar;

our $dsl = <<'END_OF_DSL';
:default ::= action => do_print
lexeme default = latm => 1
:start ::= Expression 
ExpressionList ::= Expression ExpressionList 
| Expression 
Expression ::= Notation 
 || Presentation 
Presentation ::= rowB ExpressionList rowE
 | moB Expression moE 
 | miB Expression miE 
moB ::= ws '<mo>' ws
moE ::= ws '</mo>' ws
miB ::= ws '<mi>' ws
miE ::= ws '</mi>' ws
rowB ::= ws '<mrow>' ws
rowE ::= ws '</mrow>' ws
ws ~ space*
space ~ [\s] 
Notation ::= _equal_notequal_
| _equal_notequal
| _equal_eq_
| _equal_eq
| _argseq_nasequi_
| _argseq_nasequi
| _argseq_naseqli_
| _argseq_naseqli
| _argseq_naseqe_
| _argseq_naseqe
| _argseq_aseqfromto_
| _argseq_aseqfromto
| _argseq_dotsaseqdots_
| _argseq_dotsaseqdots
| _argseq_dotsaseq_
| _argseq_dotsaseq
| _argseq_aseqdots_
| _argseq_aseqdots
| _structure_structure
| _defeq_defeq_
| _defeq_defeq
_argseq_aseqdots::= rule1 rule11 rule9 rule13 rule7
rule21::= Expression
rule5::= moB '=' moE
rule8::= moB '⟨' moE
rule19::= Expression
rule4::= moB '⁣' moE
rule1::= moB '(' moE
_argseq_aseqfromto::= rule1 rule10 rule9 rule13 rule9 rule15 rule7
rule13::= moB '⋯' moE
_equal_eq_::= rule5
_argseq_naseqli_::= rule1 rule10 rule15 rule9 rule14 rule9 rule10 rule16 rule7
rule2::= Expression
rule11::= rule10 | rule11 rule9 rule10
rule14::= moB '…' moE
_defeq_defeq_::= rule3 rule4 rule5
rule10::= Expression
_argseq_naseqe_::= rule1 rule11 rule9 rule14 rule9 rule15 rule7
rule6::= Expression
_argseq_dotsaseq_::= rule1 rule14 rule9 rule11 rule7
_argseq_naseqe::= rule1 rule11 rule9 rule13 rule9 rule15 rule7
_argseq_nasequi_::= rule1 rule10 rule15 rule9 rule14 rule9 rule10 rule16 rule7
_argseq_nasequi::= rule1 rule10 rule15 rule9 rule13 rule9 rule10 rule16 rule7
rule17::= Expression
rule20::= moB '≠' moE
_argseq_aseqdots_::= rule1 rule11 rule9 rule14 rule7
rule18::= rule17 | rule18 rule5 rule17
_argseq_dotsaseq::= rule1 rule13 rule9 rule11 rule7
_equal_eq::= rule1 rule18 rule7
_equal_notequal::= rule1 rule19 rule20 rule21 rule7
rule16::= Expression
rule9::= moB ',' moE
_equal_notequal_::= rule20
_defeq_defeq::= rule1 rule2 rule3 rule4 rule5 rule6 rule7
rule15::= Expression
rule3::= moB ':' moE
rule12::= moB '⟩' moE
_argseq_dotsaseqdots_::= rule1 rule14 rule9 rule11 rule9 rule14 rule7
_argseq_dotsaseqdots::= rule1 rule13 rule9 rule11 rule9 rule13 rule7
rule7::= moB ')' moE
_argseq_aseqfromto_::= rule1 rule10 rule9 rule14 rule9 rule15 rule7
_argseq_naseqli::= rule1 rule10 rule15 rule9 rule13 rule9 rule10 rule16 rule7
_structure_structure::= rule1 rule8 rule11 rule12 rule7
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
