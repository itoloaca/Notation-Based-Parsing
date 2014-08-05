package My_Grammar;

our $dsl = <<END_OF_DSL;
#Manually generated part
:default ::= action => [name, start, length, values]
lexeme default = latm => 1
:start ::= Expr 
ExprList ::= Expr+
Expr ::= Notation 
 | Presentation 
Presentation ::= mrowB ExprList mrowE 
 | moB '(' moE ExprList moB ')' moE 
 | moB text moE 
 | miB text miE 
 | mnB text mnE 
 | emB text emE 
 | mtextB ExprList mtextE
 | mtextB text mtextE 
 | msB text msE 
 | mfracB ExprList mfracE
 | msqrtB Expr msqrtE
 | msupB ExprList msupE
 | msubB ExprList msubE
 | msubsupB ExprList msubsupE
 | munderB ExprList munderE 
 | moverB ExprList moverE 
 | munderoverB ExprList munderoverE 
 | mtdB ExprList mtdE
 | mtrB ExprList mtrE
 | mtableB ExprList mtableE 
 | mathB ExprList mathE 
 | emB ExprList emE 
 | mstyleB ExprList mstyleE 
 | mspaceB mspaceE 
 | miSingle 
 | moSingle 
 | mtdSingle 
 | mtrSingle 
 | mtableSingle 
 | mrowSingle 
mfracB ::= '<mfrac' attribs '>' 
mfracE ::= '</mfrac>' 
msqrtB ::= '<msqrt' attribs '>' 
msqrtE ::= '</msqrt>' 
msupB ::= '<msup' attribs '>' 
msupE ::= '</msup>' 
msubB ::= '<msub' attribs '>' 
msubE ::= '</msub>' 
munderB ::= '<munder' attribs '>' 
munderE ::= '</munder>' 
moverB ::= '<mover' attribs '>' 
moverE ::= '</mover>' 
mnB ::= '<mn' attribs '>' 
mnE ::= '</mn>' 
miB ::= '<mi' attribs '>' 
miE ::= '</mi>' 
msB ::= '<ms' attribs '>' 
msE ::= '</ms>' 
mspaceB ::= '<mspace' attribs '>' 
mspaceE ::= '</mspace>' 
moB ::= '<mo' attribs '>' 
moE ::= '</mo>' 
mstyleB ::= '<mstyle' attribs '>' 
mstyleE ::= '</mstyle>' 
mtextB ::= '<mtext' attribs '>' 
mtextE ::= '</mtext>' 
emB ::= '<em' attribs '>' 
emE ::= '</em>' 
mtdB ::= '<mtd' attribs '>' 
mtdE ::= '</mtd>' 
mtrB ::= '<mtr' attribs '>' 
mtrE ::= '</mtr>' 
mtableB ::= '<mtable' attribs '>' 
mtableE ::= '</mtable>' 
msubsupB ::= '<msubsup' attribs '>' 
msubsupE ::= '</msubsup>' 
munderoverB ::= '<munderover' attribs '>' 
munderoverE ::= '</munderover>' 
mrowB ::= '<mrow' attribs '>' 
mrowE ::= '</mrow>' 
mathB ::= '<math' attribs '>' 
mathE ::= '</math>' 
miSingle ::= '<mi' attribs '/>' 
moSingle ::= '<mo' attribs '/>' 
mtdSingle ::= '<mtd' attribs '/>' 
mtrSingle ::= '<mtr' attribs '/>' 
mtableSingle ::= '<mtable' attribs '/>' 
mrowSingle ::= '<mrow' attribs '/>' 
ws ::= spaces
ws ::= # empty
spaces ~ space+
space ~ [\s] 
attribs ::= ws
attribs::= attribRule
attribRule ::= attrib || attrib attribRule
 attrib ::= ws notEqSignS '=' ws '"' notQuoteS '"' ws
notEqSignS ~ notEqSign+ 
notEqSign ~ [^=<>/]
notQuoteS ~ notQuote+ 
notQuote ~ [^"<>]
 text ::= textRule
textRule::= char | char textRule 
 text ::= #empty
 char ~ [^<>]
 argRule ::= Expr # Presentation |Content 
#Automatically generated part
Notation ::= _set_ninsetN134

_set_ninsetN134::= argRuleN134A1Arg rule315 argRuleN134A2Arg 
argRuleN134A1Arg::= argRule
rule315::= moB 'my_symbol' moE
argRuleN134A2Arg::= argRule

event '_set_ninsetN134' = completed _set_ninsetN134

END_OF_DSL
1;

#INPUT: <math xmlns="http://www.w3.org/1998/Math/MathML"><mrow><mi>K1</mi><mo>my_symbol</mo><mi>L</mi></mrow></math> 
#OUTPUT:

# <math xmlns="http://www.w3.org/1998/Math/MathML"><mrow><mi>K1</mi><mo>my_symbol</mo><mi>L</mi></mrow></math>  
# Trimmed input: 
# <math xmlns="http://www.w3.org/1998/Math/MathML"><mrow><mi>K1</mi><mo>my_symbol</mo><mi>L</mi></mrow></math> 
# Actual events: $VAR1 = [
#           [
#             84,
#             10,
#             '_set_ninsetN134'
#           ]
#         ];
# [Finished in 0.5s]