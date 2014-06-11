#!/usr/local/bin/perl
use utf8;
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common;
use English qw( -no_match_vars );
use Marpa::R2;
use My_Actions;
use Encode;
use XML::LibXML;
use Data::Dumper;
my $dom = XML::LibXML->load_xml(location=>"1311.1412.xhtml"); 
my $nc = XML::LibXML::XPathContext->new($dom); 
$nc->registerNs("m","http://www.w3.org/1998/Math/MathML"); 
my @math_elements = $nc->findnodes("//m:math"); 
print scalar(@math_elements),"\n";
print $math_elements[1];