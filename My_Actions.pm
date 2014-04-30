package My_Actions;
use Data::Dumper;
sub do_add {
    print "DO ADD\n";
    my ( undef, $t1, undef, $t2 ) = @_;
    return $t1 + $t2;
}

sub do_multiply {
	print "DO MULTIPLY\n";
    my ( undef, $t1, undef, $t2 ) = @_;
    return $t1 * $t2;
}

sub do_print {
	
	print "###############################\nUsing default action\n";
	print Dumper(\$_[0]);
	shift;
	print join("\n",@_). "\n";
	return $_[0] + $_[2];
}

sub do_printNr {
	
	print "###############################\nUsing do_printNr\n";
	print Dumper(\$_[0]);
	shift;
	print join("\n",@_). "\n";
	return $_[0] + $_[2];
}

sub do_printAny {
	
	print "###############################\nUsing do_printAny\n";
	print Dumper(\$_[0]);
	shift;
	print join("\n",@_). "\n";
	return $_[0] + $_[2];
}

1; #required