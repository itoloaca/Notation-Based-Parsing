package My_Grammar;

our $dsl = <<END_OF_DSL;
:default ::= action => getString

lexeme default = latm => 1
:start ::= Expression 
ExpressionList ::= Expression ExpressionList 
| Expression 
Expression ::= Notation 
 || Presentation 
Presentation ::= rowB ExpressionList rowE
 | moB '(' moE Expression moB ')' moE 
 | moB Expression moE 
 | miB Expression miE 
 | mnB Expression mnE 
 | mfracB Expression Expression mfracE
 | msqrtB Expression msqrtE
 | msupB Expression Expression msupE
 | msubB Expression Expression msubE
 || texts 
mfracB ::= ws '<mfrac' attribs '>' ws
mfracE ::= ws '</mfrac>' ws
msqrtB ::= ws '<msqrt' attribs '>' ws
msqrtE ::= ws '</msqrt>' ws
msupB ::= ws '<msup' attribs '>' ws
msupE ::= ws '</msup>' ws
msubB ::= ws '<msub' attribs '>' ws
msubE ::= ws '</msub>' ws
mnB ::= ws '<mn' attribs '>' ws
mnE ::= ws '</mn>' ws
miB ::= ws '<mi' attribs '>' ws
miE ::= ws '</mi>' ws
moB ::= ws '<mo' attribs '>' ws
moE ::= ws '</mo>' ws
rowB ::= ws '<mrow' attribs '>' ws
rowE ::= ws '</mrow>' ws
ws ::= spaces
ws::= # empty
spaces ~ space+
space ~ [\s] 
attribs ::= texts
attribs ::= 
 texts ~ text+
 text ~ [^<>]
Automatically generated part
Notation ::= _generalizedtaxicabnumber_gentaxicab_
| _generalizedtaxicabnumber_gentaxicab
| _goldenratio_goldenratio
| _mersennenumber_Mnumber
| _cullennumber_cullnumber_
| _cullennumber_cullnumber
| _cabtaxinumber_cabtaxi_
| _cabtaxinumber_cabtaxi
| _centraldelannoynumber_centraldelannoynumber_
| _centraldelannoynumber_centraldelannoynumber
| _normalizedsinc_normsinc_
| _normalizedsinc_normsinc
| _doublemersennenumber_doubleMnumber
| _eulerstotientfunction_eulerphi_
| _eulerstotientfunction_eulerphi
| _fermatnumber_FNumber
| _equal_notequal_
| _equal_notequal
| _equal_eq_
| _equal_eq
| _cosineintegralsmall_cosineintsmall_
| _cosineintegralsmall_cosineintsmall
| _primenumber_NumberPrimeNumber_
| _primenumber_NumberPrimeNumber
| _primenumber_nPrimeNumber
| _primenumber_PrimeNumber
| _repunit_repunit
| _abstract_reduction_system_arsRconvtr_
| _abstract_reduction_system_arsRconvtr
| _abstract_reduction_system_arsconvtr__
| _abstract_reduction_system_arsconvtr_
| _abstract_reduction_system_arsconvtr
| _abstract_reduction_system_arsRconv_
| _abstract_reduction_system_arsRconv
| _abstract_reduction_system_arsconv__
| _abstract_reduction_system_arsconv_
| _abstract_reduction_system_arsconv
| _lobbnumbers_lobbnumber
| _sineintegralbig_sineintbig_
| _sineintegralbig_sineintbig
| _jacobsthalnumbers_jacobsthalnum
| _radicalofaninteger_radint
| _rootmeansquare_rootmean_
| _rootmeansquare_rootmean
| _sylvestersequence_sylvester
| _primorial_primorial
| _coprime_coprime
| _motzkinnumber_motzkin
| _alpharenaming_nalphaeq_
| _alpharenaming_nalphaeq
| _alpharenaming_alphaeqRel
| _alpharenaming_alphaeq
| _primegap_primegap
| _smarandachefunction_smarandachefunc__
| _smarandachefunction_smarandachefunc_
| _smarandachefunction_smarandachefunc
| _delannoynumber_delannoynumber_
| _delannoynumber_delannoynumber
| _schroederhipparchusnumberrec_schroederhipprec_
| _schroederhipparchusnumberrec_schroederhipprec
| _asymptoticdensity_asdensity_
| _asymptoticdensity_asdensity
| _plasticnumber_plasticnum
| _approxeq_approxeq_
| _approxeq_approxeq
| _millsconstant_millsconst
| _moebiusfunction_moebiusfunc
| _franelnumberrecurrence_franelnumberrec
| _taxicabnumber_taxicab_
| _taxicabnumber_taxicab
| _euclidnumber_euclidnumb
| _uvulamnumber_uvulam
| _sumofsquaresfunction_sumsquarefunc
| _pythagoreantriple_pythtriple
| _pythagoreanquadruple_pythquad
| _fibonaccinumbers_fibnum
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
| _silverratio_silverratio
| _pronicnumber_pronicnumber
| _cosineintegralint_cosineintint_
| _cosineintegralint_cosineintint
| _wilsonquotient_wilsonquotient_
| _wilsonquotient_wilsonquotient
| _logarithmicintegralbig_logarithmicintbig_
| _logarithmicintegralbig_logarithmicintbig
| _perrinnumbers_perrnum
| _mersenneprime_Mprime
| _fermatprime_Fprime
| _brunconstant_brunconstant
| _cakenumber_cake
| _leastprimefactor_leastprimefactor_
| _leastprimefactor_leastprimefactor
| _padovannumbers_padonum
| _narayananumber_narayananumber_
| _narayananumber_narayananumber
| _highlycompositenumber_highlycompositenumber
| _lucasnumbers_lucnum
| _unnormalizedsinc_unnormsinc_
| _unnormalizedsinc_unnormsinc
| _hyperbolicsineintegral_hyperbolicsineint__
| _hyperbolicsineintegral_hyperbolicsineint_
| _hyperbolicsineintegral_hyperbolicsineint
| _fareysequence_fareyseq
| _skewesnumber_skewesnumber
| _skewesnumber_skewesnumberriemann
| _woodallnumber_woodnumber
| _schroederhipparchusnumber_schroederhipp_
| _schroederhipparchusnumber_schroederhipp
| _ulamnumber_ulam
| _structure_structure
| _sineintegralsmall_sineintsmall_
| _sineintegralsmall_sineintsmall
| _defeq_defequiv_
| _defeq_defequiv
| _defeq_eqdef_
| _defeq_eqdef
| _defeq_defeq_
| _defeq_defeq
| _brunconstantcousin_brunconstantcousin
| _berahaconstants_berahaconstant_
| _berahaconstants_berahaconstant
| _pelllucasnumbers_pellucnum
| _numbertheoreticfunction_Idnumbertheoreticfunction
| _binomialcoefficient_binomcoeff
| _brunconstantquad_brunconstantquad
| _aliquotsum_alisum_
| _aliquotsum_alisum
rule22::= moB ',' moE #Delimiter
rule15::= Expression || texts
_alpharenaming_nalphaeq_::= rule65 rule63
_perrinnumbers_perrnum::= rule40 rule3
_asymptoticdensity_asdensity::= rule60 rule2 rule3 rule4
_eulerstotientfunction_eulerphi_::= rule83
_primenumber_NumberPrimeNumber::= rule78 rule2 rule3 rule4
_schroederhipparchusnumber_schroederhipp_::= rule26
rule27::= moB 'W' moE #Delimiter
_sylvestersequence_sylvester::= rule1 rule3
_wilsonquotient_wilsonquotient::= rule27 rule2 rule3 rule4
rule43::= moB 'Li' moE #Delimiter
_defeq_defequiv_::= rule19
rule41::= moB 'lpf' moE #Delimiter
_eulerstotientfunction_eulerphi::= rule83 rule2 rule3 rule4
rule84::= moB 'Cabtaxi' moE #Delimiter
_millsconstant_millsconst::= rule56
_binomialcoefficient_binomcoeff::= rule2 'TODO' rule4
_argseq_dotsaseqdots_::= rule47 rule22 rule23 rule22 rule47
rule38::= moB 'N' moE #Delimiter
_argseq_naseqli::= rule16 rule18 rule22 rule46 rule22 rule16 rule48
rule32::= moB 'Shi' moE #Delimiter
_hyperbolicsineintegral_hyperbolicsineint__::= rule32
rule36::= moB 'H' moE #Delimiter
_primenumber_NumberPrimeNumber_::= rule78
_pelllucasnumbers_pellucnum::= rule9 rule3
rule55::= moB 'μ' moE #Delimiter
_argseq_aseqdots::= rule23 rule22 rule46
rule7::= moB 'I' moE #Delimiter
rule16::= Expression || texts
_alpharenaming_nalphaeq::= rule64 rule65 rule63 rule66
_narayananumber_narayananumber_::= rule38
_defeq_defeq::= rule11 rule12 rule13 rule14 rule15
_abstract_reduction_system_arsconvtr__::= rule74
_narayananumber_narayananumber::= rule38 rule2 rule3 rule22 rule39 rule4
rule70::= moB 'm' moE #Delimiter
_argseq_naseqe_::= rule23 rule22 rule47 rule22 rule18
_skewesnumber_skewesnumberriemann::= rule26 rule8 rule28 rule29
_equal_notequal::= rule81 rule65 rule82
_cosineintegralsmall_cosineintsmall::= rule79 rule2 rule3 rule4
_lobbnumbers_lobbnumber::= rule35 rule3 rule22 rule39
rule24::= moB '⟩' moE #Delimiter
_delannoynumber_delannoynumber_::= rule61
_sineintegralsmall_sineintsmall::= rule20 rule2 rule3 rule4
rule23::= rule16 rule22 rule23 || rule16
_mersenneprime_Mprime::= rule42 rule3
rule53::= moB 'Ta' moE #Delimiter
rule58::= rule3 rule57 rule58 || rule3
rule39::= Expression || texts
rule81::= Expression || texts
rule25::= moB 'U' moE #Delimiter
_motzkinnumber_motzkin::= rule42 rule3
_franelnumberrecurrence_franelnumberrec::= rule54 rule3
_smarandachefunction_smarandachefunc::= rule26 rule2 rule3 rule4
_fermatprime_Fprime::= rule31 rule3
rule40::= moB 'P' moE #Delimiter
rule20::= moB 'si' moE #Delimiter
_abstract_reduction_system_arsconvtr::= rule64 rule74 rule66
rule44::= moB 'Cin' moE #Delimiter
_argseq_dotsaseqdots::= rule46 rule22 rule23 rule22 rule46
rule72::= moB 'J' moE #Delimiter
rule30::= moB '2' moE #Delimiter
_abstract_reduction_system_arsRconvtr::= rule74 rule3
_logarithmicintegralbig_logarithmicintbig_::= rule43
rule54::= moB 'Fr' moE #Delimiter
rule10::= moB '𝐵' moE #Delimiter
rule74::= moB '→' moE #Delimiter
rule18::= Expression || texts
_wilsonquotient_wilsonquotient_::= rule27
_sineintegralbig_sineintbig_::= rule73
_normalizedsinc_normsinc_::= rule34
rule46::= moB '⋯' moE #Delimiter
rule12::= moB ':' moE #Delimiter
rule75::= Expression || texts
_fermatnumber_FNumber::= rule31 rule3
rule42::= moB 'M' moE #Delimiter
_centraldelannoynumber_centraldelannoynumber::= rule61 rule2 rule3 rule4
_silverratio_silverratio::= rule45 rule1
_sineintegralbig_sineintbig::= rule73 rule2 rule3 rule4
_sumofsquaresfunction_sumsquarefunc::= rule51 rule3 rule2 rule39 rule4
_argseq_nasequi::= rule16 rule18 rule22 rule46 rule22 rule16 rule48
_equal_eq_::= rule14
_alpharenaming_alphaeq::= rule63
rule83::= moB 'φ' moE #Delimiter
rule52::= moB 'E' moE #Delimiter
_uvulamnumber_uvulam::= rule25 rule3
rule19::= moB ':⇔' moE #Delimiter
_pronicnumber_pronicnumber::= rule40 rule3
_radicalofaninteger_radint::= rule71 rule8 rule2 rule3 rule4
_euclidnumber_euclidnumb::= rule52 rule3
_approxeq_approxeq_::= rule57
_numbertheoreticfunction_Idnumbertheoreticfunction::= rule7 rule8 rule2 rule3 rule4
rule17::= moB '=:' moE #Delimiter
rule76::= moB 'R' moE #Delimiter
_abstract_reduction_system_arsRconv::= rule74 rule3
_highlycompositenumber_highlycompositenumber::= rule36 rule8 rule37 rule8 rule38
_mersennenumber_Mnumber::= rule42 rule3
_brunconstant_brunconstant::= rule5 rule30
rule45::= moB 'δ' moE #Delimiter
rule37::= moB 'C' moE #Delimiter
_primenumber_nPrimeNumber::= rule77 rule3
rule77::= moB 'p' moE #Delimiter
_fareysequence_fareyseq::= rule31 rule3
_berahaconstants_berahaconstant::= rule10 rule2 rule3 rule4
_brunconstantcousin_brunconstantcousin::= rule5 rule6
_plasticnumber_plasticnum::= rule59
_approxeq_approxeq::= rule58
rule26::= moB 'S' moE #Delimiter
_cosineintegralint_cosineintint_::= rule44
rule21::= moB '⟨' moE #Delimiter
_aliquotsum_alisum::= rule1 rule2 rule3 rule4
_woodallnumber_woodnumber::= rule27 rule3
rule13::= moB '⁣' moE #Delimiter
_equal_eq::= rule80
rule34::= moB 'sinc' moE #Delimiter
rule50::= Expression || texts
rule28::= moB 'k' moE #Delimiter
rule62::= moB 'g' moE #Delimiter
rule56::= moB 'A' moE #Delimiter
rule33::= moB 'shi' moE #Delimiter
rule6::= moB '4' moE #Delimiter
rule5::= moB 'B' moE #Delimiter
_skewesnumber_skewesnumber::= rule26 rule8 rule28 rule30
_centraldelannoynumber_centraldelannoynumber_::= rule61
_aliquotsum_alisum_::= rule1
_abstract_reduction_system_arsconv__::= rule74
_defeq_eqdef::= rule16 rule17 rule18
_cabtaxinumber_cabtaxi_::= rule84
_cakenumber_cake::= rule37 rule3
_repunit_repunit::= rule76 rule3
rule71::= moB 'rad' moE #Delimiter
_pythagoreantriple_pythtriple::= rule2 rule3 rule22 rule39 rule22 rule49 rule4
_normalizedsinc_normsinc::= rule34 rule2 rule3 rule4
_defeq_defequiv::= rule16 rule19 rule18
_alpharenaming_alphaeqRel::= rule14 rule63
_jacobsthalnumbers_jacobsthalnum::= rule72 rule3
_taxicabnumber_taxicab_::= rule53
rule3::= Expression || texts
rule65::= moB '≠' moE #Delimiter
_leastprimefactor_leastprimefactor::= rule41 rule2 rule3 rule4
rule59::= moB 'ρ' moE #Delimiter
_abstract_reduction_system_arsRconvtr_::= rule66 rule74 rule64 rule75
rule67::= moB '⊥' moE #Delimiter
_lucasnumbers_lucnum::= rule35 rule3
_schroederhipparchusnumberrec_schroederhipprec::= rule26 rule2 rule3 rule4
_smarandachefunction_smarandachefunc_::= rule55
_structure_structure::= rule21 rule23 rule24
_doublemersennenumber_doubleMnumber::= rule42 rule42 rule3
_abstract_reduction_system_arsRconv_::= rule66 rule74 rule64 rule75
_cabtaxinumber_cabtaxi::= rule84 rule2 rule3 rule4
_abstract_reduction_system_arsconv_::= rule74 rule29
_generalizedtaxicabnumber_gentaxicab::= rule85 rule2 rule3 rule22 rule39 rule22 rule49 rule4
_padovannumbers_padonum::= rule40 rule3
rule29::= moB '1' moE #Delimiter
_primegap_primegap::= rule62 rule3
rule35::= moB 'L' moE #Delimiter
rule60::= moB 'd' moE #Delimiter
_cullennumber_cullnumber::= rule37 rule3
rule78::= moB 'π' moE #Delimiter
rule47::= moB '…' moE #Delimiter
_abstract_reduction_system_arsconv::= rule64 rule74 rule66
_defeq_eqdef_::= rule17
_schroederhipparchusnumberrec_schroederhipprec_::= rule26
_equal_notequal_::= rule65
_argseq_naseqli_::= rule16 rule18 rule22 rule47 rule22 rule16 rule48
_moebiusfunction_moebiusfunc::= rule55 rule8 rule2 rule3 rule4
_logarithmicintegralbig_logarithmicintbig::= rule43 rule2 rule3 rule4
_goldenratio_goldenratio::= rule83
_asymptoticdensity_asdensity_::= rule60
_hyperbolicsineintegral_hyperbolicsineint_::= rule33
rule79::= moB 'ci' moE #Delimiter
_argseq_nasequi_::= rule16 rule18 rule22 rule47 rule22 rule16 rule48
_argseq_aseqfromto::= rule16 rule22 rule46 rule22 rule18
rule31::= moB 'F' moE #Delimiter
_generalizedtaxicabnumber_gentaxicab_::= rule85
_delannoynumber_delannoynumber::= rule61 rule2 rule3 rule22 rule39 rule4
rule85::= moB 'Taxicab' moE #Delimiter
_berahaconstants_berahaconstant_::= rule10
rule49::= Expression || texts
_cosineintegralint_cosineintint::= rule44 rule2 rule3 rule4
rule9::= moB 'Q' moE #Delimiter
rule11::= Expression || texts
rule68::= moB '#' moE #Delimiter
_fibonaccinumbers_fibnum::= rule31 rule3
_coprime_coprime::= rule67
rule73::= moB 'Si' moE #Delimiter
_argseq_dotsaseq::= rule46 rule22 rule23
_argseq_aseqfromto_::= rule16 rule22 rule47 rule22 rule18
_rootmeansquare_rootmean::= rule69 rule51 rule8 rule1 rule8 rule70
rule2::= moB '(' moE #Delimiter
rule66::= Expression || texts
rule69::= moB 'x' moE #Delimiter
rule14::= moB '=' moE #Delimiter
_sineintegralsmall_sineintsmall_::= rule20
rule82::= Expression || texts
_unnormalizedsinc_unnormsinc_::= rule34
_leastprimefactor_leastprimefactor_::= rule41
_argseq_naseqe::= rule23 rule22 rule46 rule22 rule18
_primenumber_PrimeNumber::= rule77
_cullennumber_cullnumber_::= rule37
rule61::= moB 'D' moE #Delimiter
rule80::= rule3 rule14 rule80 || rule3
_unnormalizedsinc_unnormsinc::= rule34 rule2 rule3 rule4
_cosineintegralsmall_cosineintsmall_::= rule79
_ulamnumber_ulam::= rule25 rule3
_brunconstantquad_brunconstantquad::= rule5 rule6
rule1::= moB 's' moE #Delimiter
_schroederhipparchusnumber_schroederhipp::= rule26 rule2 rule3 rule4
_abstract_reduction_system_arsconvtr_::= rule74 rule29
rule8::= moB '⁢' moE #Delimiter
_taxicabnumber_taxicab::= rule53 rule2 rule3 rule4
rule64::= Expression || texts
rule48::= Expression || texts
_argseq_dotsaseq_::= rule47 rule22 rule23
_hyperbolicsineintegral_hyperbolicsineint::= rule32 rule2 rule3 rule4
rule57::= moB '≡' moE #Delimiter
rule4::= moB ')' moE #Delimiter
_defeq_defeq_::= rule12 rule13 rule14
_argseq_aseqdots_::= rule23 rule22 rule47
rule51::= moB 'r' moE #Delimiter
rule63::= moB 'α' moE #Delimiter
_smarandachefunction_smarandachefunc__::= rule26
_primorial_primorial::= rule68
_rootmeansquare_rootmean_::= rule9 rule42
_pythagoreanquadruple_pythquad::= rule2 rule3 rule22 rule39 rule22 rule49 rule22 rule50 rule4
event '_generalizedtaxicabnumber_gentaxicab_' = completed _generalizedtaxicabnumber_gentaxicab_
event '_generalizedtaxicabnumber_gentaxicab' = completed _generalizedtaxicabnumber_gentaxicab
event '_goldenratio_goldenratio' = completed _goldenratio_goldenratio
event '_mersennenumber_Mnumber' = completed _mersennenumber_Mnumber
event '_cullennumber_cullnumber_' = completed _cullennumber_cullnumber_
event '_cullennumber_cullnumber' = completed _cullennumber_cullnumber
event '_cabtaxinumber_cabtaxi_' = completed _cabtaxinumber_cabtaxi_
event '_cabtaxinumber_cabtaxi' = completed _cabtaxinumber_cabtaxi
event '_centraldelannoynumber_centraldelannoynumber_' = completed _centraldelannoynumber_centraldelannoynumber_
event '_centraldelannoynumber_centraldelannoynumber' = completed _centraldelannoynumber_centraldelannoynumber
event '_normalizedsinc_normsinc_' = completed _normalizedsinc_normsinc_
event '_normalizedsinc_normsinc' = completed _normalizedsinc_normsinc
event '_doublemersennenumber_doubleMnumber' = completed _doublemersennenumber_doubleMnumber
event '_eulerstotientfunction_eulerphi_' = completed _eulerstotientfunction_eulerphi_
event '_eulerstotientfunction_eulerphi' = completed _eulerstotientfunction_eulerphi
event '_fermatnumber_FNumber' = completed _fermatnumber_FNumber
event '_equal_notequal_' = completed _equal_notequal_
event '_equal_notequal' = completed _equal_notequal
event '_equal_eq_' = completed _equal_eq_
event '_equal_eq' = completed _equal_eq
event '_cosineintegralsmall_cosineintsmall_' = completed _cosineintegralsmall_cosineintsmall_
event '_cosineintegralsmall_cosineintsmall' = completed _cosineintegralsmall_cosineintsmall
event '_primenumber_NumberPrimeNumber_' = completed _primenumber_NumberPrimeNumber_
event '_primenumber_NumberPrimeNumber' = completed _primenumber_NumberPrimeNumber
event '_primenumber_nPrimeNumber' = completed _primenumber_nPrimeNumber
event '_primenumber_PrimeNumber' = completed _primenumber_PrimeNumber
event '_repunit_repunit' = completed _repunit_repunit
event '_abstract_reduction_system_arsRconvtr_' = completed _abstract_reduction_system_arsRconvtr_
event '_abstract_reduction_system_arsRconvtr' = completed _abstract_reduction_system_arsRconvtr
event '_abstract_reduction_system_arsconvtr__' = completed _abstract_reduction_system_arsconvtr__
event '_abstract_reduction_system_arsconvtr_' = completed _abstract_reduction_system_arsconvtr_
event '_abstract_reduction_system_arsconvtr' = completed _abstract_reduction_system_arsconvtr
event '_abstract_reduction_system_arsRconv_' = completed _abstract_reduction_system_arsRconv_
event '_abstract_reduction_system_arsRconv' = completed _abstract_reduction_system_arsRconv
event '_abstract_reduction_system_arsconv__' = completed _abstract_reduction_system_arsconv__
event '_abstract_reduction_system_arsconv_' = completed _abstract_reduction_system_arsconv_
event '_abstract_reduction_system_arsconv' = completed _abstract_reduction_system_arsconv
event '_lobbnumbers_lobbnumber' = completed _lobbnumbers_lobbnumber
event '_sineintegralbig_sineintbig_' = completed _sineintegralbig_sineintbig_
event '_sineintegralbig_sineintbig' = completed _sineintegralbig_sineintbig
event '_jacobsthalnumbers_jacobsthalnum' = completed _jacobsthalnumbers_jacobsthalnum
event '_radicalofaninteger_radint' = completed _radicalofaninteger_radint
event '_rootmeansquare_rootmean_' = completed _rootmeansquare_rootmean_
event '_rootmeansquare_rootmean' = completed _rootmeansquare_rootmean
event '_sylvestersequence_sylvester' = completed _sylvestersequence_sylvester
event '_primorial_primorial' = completed _primorial_primorial
event '_coprime_coprime' = completed _coprime_coprime
event '_motzkinnumber_motzkin' = completed _motzkinnumber_motzkin
event '_alpharenaming_nalphaeq_' = completed _alpharenaming_nalphaeq_
event '_alpharenaming_nalphaeq' = completed _alpharenaming_nalphaeq
event '_alpharenaming_alphaeqRel' = completed _alpharenaming_alphaeqRel
event '_alpharenaming_alphaeq' = completed _alpharenaming_alphaeq
event '_primegap_primegap' = completed _primegap_primegap
event '_smarandachefunction_smarandachefunc__' = completed _smarandachefunction_smarandachefunc__
event '_smarandachefunction_smarandachefunc_' = completed _smarandachefunction_smarandachefunc_
event '_smarandachefunction_smarandachefunc' = completed _smarandachefunction_smarandachefunc
event '_delannoynumber_delannoynumber_' = completed _delannoynumber_delannoynumber_
event '_delannoynumber_delannoynumber' = completed _delannoynumber_delannoynumber
event '_schroederhipparchusnumberrec_schroederhipprec_' = completed _schroederhipparchusnumberrec_schroederhipprec_
event '_schroederhipparchusnumberrec_schroederhipprec' = completed _schroederhipparchusnumberrec_schroederhipprec
event '_asymptoticdensity_asdensity_' = completed _asymptoticdensity_asdensity_
event '_asymptoticdensity_asdensity' = completed _asymptoticdensity_asdensity
event '_plasticnumber_plasticnum' = completed _plasticnumber_plasticnum
event '_approxeq_approxeq_' = completed _approxeq_approxeq_
event '_approxeq_approxeq' = completed _approxeq_approxeq
event '_millsconstant_millsconst' = completed _millsconstant_millsconst
event '_moebiusfunction_moebiusfunc' = completed _moebiusfunction_moebiusfunc
event '_franelnumberrecurrence_franelnumberrec' = completed _franelnumberrecurrence_franelnumberrec
event '_taxicabnumber_taxicab_' = completed _taxicabnumber_taxicab_
event '_taxicabnumber_taxicab' = completed _taxicabnumber_taxicab
event '_euclidnumber_euclidnumb' = completed _euclidnumber_euclidnumb
event '_uvulamnumber_uvulam' = completed _uvulamnumber_uvulam
event '_sumofsquaresfunction_sumsquarefunc' = completed _sumofsquaresfunction_sumsquarefunc
event '_pythagoreantriple_pythtriple' = completed _pythagoreantriple_pythtriple
event '_pythagoreanquadruple_pythquad' = completed _pythagoreanquadruple_pythquad
event '_fibonaccinumbers_fibnum' = completed _fibonaccinumbers_fibnum
event '_argseq_nasequi_' = completed _argseq_nasequi_
event '_argseq_nasequi' = completed _argseq_nasequi
event '_argseq_naseqli_' = completed _argseq_naseqli_
event '_argseq_naseqli' = completed _argseq_naseqli
event '_argseq_naseqe_' = completed _argseq_naseqe_
event '_argseq_naseqe' = completed _argseq_naseqe
event '_argseq_aseqfromto_' = completed _argseq_aseqfromto_
event '_argseq_aseqfromto' = completed _argseq_aseqfromto
event '_argseq_dotsaseqdots_' = completed _argseq_dotsaseqdots_
event '_argseq_dotsaseqdots' = completed _argseq_dotsaseqdots
event '_argseq_dotsaseq_' = completed _argseq_dotsaseq_
event '_argseq_dotsaseq' = completed _argseq_dotsaseq
event '_argseq_aseqdots_' = completed _argseq_aseqdots_
event '_argseq_aseqdots' = completed _argseq_aseqdots
event '_silverratio_silverratio' = completed _silverratio_silverratio
event '_pronicnumber_pronicnumber' = completed _pronicnumber_pronicnumber
event '_cosineintegralint_cosineintint_' = completed _cosineintegralint_cosineintint_
event '_cosineintegralint_cosineintint' = completed _cosineintegralint_cosineintint
event '_wilsonquotient_wilsonquotient_' = completed _wilsonquotient_wilsonquotient_
event '_wilsonquotient_wilsonquotient' = completed _wilsonquotient_wilsonquotient
event '_logarithmicintegralbig_logarithmicintbig_' = completed _logarithmicintegralbig_logarithmicintbig_
event '_logarithmicintegralbig_logarithmicintbig' = completed _logarithmicintegralbig_logarithmicintbig
event '_perrinnumbers_perrnum' = completed _perrinnumbers_perrnum
event '_mersenneprime_Mprime' = completed _mersenneprime_Mprime
event '_fermatprime_Fprime' = completed _fermatprime_Fprime
event '_brunconstant_brunconstant' = completed _brunconstant_brunconstant
event '_cakenumber_cake' = completed _cakenumber_cake
event '_leastprimefactor_leastprimefactor_' = completed _leastprimefactor_leastprimefactor_
event '_leastprimefactor_leastprimefactor' = completed _leastprimefactor_leastprimefactor
event '_padovannumbers_padonum' = completed _padovannumbers_padonum
event '_narayananumber_narayananumber_' = completed _narayananumber_narayananumber_
event '_narayananumber_narayananumber' = completed _narayananumber_narayananumber
event '_highlycompositenumber_highlycompositenumber' = completed _highlycompositenumber_highlycompositenumber
event '_lucasnumbers_lucnum' = completed _lucasnumbers_lucnum
event '_unnormalizedsinc_unnormsinc_' = completed _unnormalizedsinc_unnormsinc_
event '_unnormalizedsinc_unnormsinc' = completed _unnormalizedsinc_unnormsinc
event '_hyperbolicsineintegral_hyperbolicsineint__' = completed _hyperbolicsineintegral_hyperbolicsineint__
event '_hyperbolicsineintegral_hyperbolicsineint_' = completed _hyperbolicsineintegral_hyperbolicsineint_
event '_hyperbolicsineintegral_hyperbolicsineint' = completed _hyperbolicsineintegral_hyperbolicsineint
event '_fareysequence_fareyseq' = completed _fareysequence_fareyseq
event '_skewesnumber_skewesnumber' = completed _skewesnumber_skewesnumber
event '_skewesnumber_skewesnumberriemann' = completed _skewesnumber_skewesnumberriemann
event '_woodallnumber_woodnumber' = completed _woodallnumber_woodnumber
event '_schroederhipparchusnumber_schroederhipp_' = completed _schroederhipparchusnumber_schroederhipp_
event '_schroederhipparchusnumber_schroederhipp' = completed _schroederhipparchusnumber_schroederhipp
event '_ulamnumber_ulam' = completed _ulamnumber_ulam
event '_structure_structure' = completed _structure_structure
event '_sineintegralsmall_sineintsmall_' = completed _sineintegralsmall_sineintsmall_
event '_sineintegralsmall_sineintsmall' = completed _sineintegralsmall_sineintsmall
event '_defeq_defequiv_' = completed _defeq_defequiv_
event '_defeq_defequiv' = completed _defeq_defequiv
event '_defeq_eqdef_' = completed _defeq_eqdef_
event '_defeq_eqdef' = completed _defeq_eqdef
event '_defeq_defeq_' = completed _defeq_defeq_
event '_defeq_defeq' = completed _defeq_defeq
event '_brunconstantcousin_brunconstantcousin' = completed _brunconstantcousin_brunconstantcousin
event '_berahaconstants_berahaconstant_' = completed _berahaconstants_berahaconstant_
event '_berahaconstants_berahaconstant' = completed _berahaconstants_berahaconstant
event '_pelllucasnumbers_pellucnum' = completed _pelllucasnumbers_pellucnum
event '_numbertheoreticfunction_Idnumbertheoreticfunction' = completed _numbertheoreticfunction_Idnumbertheoreticfunction
event '_binomialcoefficient_binomcoeff' = completed _binomialcoefficient_binomcoeff
event '_brunconstantquad_brunconstantquad' = completed _brunconstantquad_brunconstantquad
event '_aliquotsum_alisum_' = completed _aliquotsum_alisum_
event '_aliquotsum_alisum' = completed _aliquotsum_alisum
END_OF_DSL
1;

