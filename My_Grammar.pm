package My_Grammar;
our $dsl = <<END_OF_DSL;
:default ::= action => getStringTEST #Prints "In get string test /value/"
:start ::= expression
expression ::= rule1 rule2 action => addToList #adds result to a list
rule1 ::= digit | digit digit
rule2 ::= digit | digit digit
event 'rule1' = completed rule1
digit ~ [0-9]
END_OF_DSL

# our $dsl1 = <<END_OF_DSL;
# #Manually generated part
# # :default ::= action => getString
# lexeme default = latm => 1
# :start ::= s
# s::=Expression action => addToList
# ExpressionList ::= Expression ExpressionList 
# | Expression 
# Expression ::= Notation 
#  || Presentation 
#  #Presentation MathML
# Presentation ::= mrowB ExpressionList mrowE
#  | moB '(' moE ExpressionList moB ')' moE 
#  | moB text moE 
#  | miB text miE 
#  | mnB text mnE 
#  | mtextB text mtextE 
#  | msB text msE 
#  | mfracB ExpressionList mfracE
#  | msqrtB Expression msqrtE
#  | msupB ExpressionList msupE
#  | msubB ExpressionList msubE
#  | msubsupB ExpressionList msubsupE
#  | munderB ExpressionList munderE 
#  | moverB ExpressionList moverE 
#  | munderoverB ExpressionList munderoverE 
#  | mtdB ExpressionList mtdE
#  | mtrB ExpressionList mtrE
#  | mtableB ExpressionList mtableE 
#  | mathB ExpressionList mathE 
#  | emB ExpressionList emE 
#  | mstyleB ExpressionList mstyleE 
#  | mspaceB mspaceE 
#  | miSingle 
# mfracB ::= ws '<mfrac' attribs '>' ws
# mfracE ::= ws '</mfrac>' ws
# msqrtB ::= ws '<msqrt' attribs '>' ws
# msqrtE ::= ws '</msqrt>' ws
# msupB ::= ws '<msup' attribs '>' ws
# msupE ::= ws '</msup>' ws
# msubB ::= ws '<msub' attribs '>' ws
# msubE ::= ws '</msub>' ws
# munderB ::= ws '<munder' attribs '>' ws
# munderE ::= ws '</munder>' ws
# moverB ::= ws '<mover' attribs '>' ws
# moverE ::= ws '</mover>' ws
# mnB ::= ws '<mn' attribs '>' ws
# mnE ::= ws '</mn>' ws
# miB ::= ws '<mi' attribs '>' ws
# miE ::= ws '</mi>' ws
# msB ::= ws '<ms' attribs '>' ws
# msE ::= ws '</ms>' ws
# mspaceB ::= ws '<mspace' attribs '>' ws
# mspaceE ::= ws '</mspace>' ws
# moB ::= ws '<mo' attribs '>' ws
# moE ::= ws '</mo>' ws
# mstyleB ::= ws '<mstyle' attribs '>' ws
# mstyleE ::= ws '</mstyle>' ws
# mtextB ::= ws '<mtext' attribs '>' ws
# mtextE ::= ws '</mtext>' ws
# emB ::= ws '<em' attribs '>' ws
# emE ::= ws '</em>' ws
# mtdB ::= ws '<mtd' attribs '>' ws
# mtdE ::= ws '</mtd>' ws
# mtrB ::= ws '<mtr' attribs '>' ws
# mtrE ::= ws '</mtr>' ws
# mtableB ::= ws '<mtable' attribs '>' ws
# mtableE ::= ws '</mtable>' ws
# msubsupB ::= ws '<msubsup' attribs '>' ws
# msubsupE ::= ws '</msubsup>' ws
# munderoverB ::= ws '<munderover' attribs '>' ws
# munderoverE ::= ws '</munderover>' ws
# mrowB ::= ws '<mrow' attribs '>' ws
# mrowE ::= ws '</mrow>' ws
# mathB ::= ws '<math' attribs '>' ws action => getString
# mathE ::= ws '</math>' ws
# miSingle ::= ws '<mi' attribs '/>' ws 
# ws ::= spaces action => getNothing
# ws ::= # empty action => getNothing
# spaces ~ space+
# space ~ [\s] 
# attribs ::= ws || attrib || attrib attribs 
# attrib ::= ws notEqSignS '=' ws '"' notQuoteS '"' ws
# notEqSignS ~ notEqSign+ 
# notEqSign ~ [^=<>/]
# notQuoteS ~ notQuote+
# notQuote ~ [^"]
# text ~ char+
# char ~ [^<>]
# argRule::= Expression
# Notation::=_equal_eqN210
# _equal_eqN210::= rule252
# rule252::= argRuleN210A1Seq2 rule53 argRuleN210A1Seq3 
# # argRuleN210A1Seq1::= argRule 
# argRuleN210A1Seq2::= argRule 
# argRuleN210A1Seq3::= argRule 
# rule53::= moB '=' moE 
# event 'rule252' = completed rule252
# event 'rule53_C' = completed rule53
# # event 'argRuleN210A1Seq1' = completed argRuleN210A1Seq1
# event 'argRuleN210A1Seq2' = completed argRuleN210A1Seq2
# event 'argRuleN210A1Seq3' = completed argRuleN210A1Seq3
# event '_equal_eqN210_C' = completed _equal_eqN210
# # event '_equal_eqN210_P' = predicted _equal_eqN210
# END_OF_DSL
1;

