package My_Grammar;
# <mrow><mi>L</mi><mi>L</mi></mrow>
our $dsl = <<END_OF_DSL;
lexeme default = latm => 1
:default ::= action => [name,start,length,values]
#The important part of the grammar 

:start ::= Expr 
ExprList ::= Expr | Expr ExprList
Expr ::= Notation | Presentation 
argRule ::= Expr
Notation ::=  L argRule 
L::= miB 'L' miE # This means "<mi>L</mi>" 
event 'Notation' = completed Notation

#This part is for parsing MathML tags and isn't closely related to the question
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
END_OF_DSL
1;
