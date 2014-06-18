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
	shift;
	my $result = join("\n",@_). "\n";
	print $result;
	return $result;
}

sub getString {
		shift;
		my $res = "";
		foreach (@_) {
			if (defined $_) {
				$res = $res . $_;
			}
		}
		return $res;	
}


sub do_printNr {
	
	print "###############################\nUsing do_printNr\n";
	shift;
	my $result = join("\n",@_). "\n";
	print $result;
	return $result;
}

sub do_printAny {
	
	print "###############################\nUsing do_printAny\n";
	print Dumper(\$_[0]);
	shift;
	my $result = join("\n",@_). "\n";
	print $result;
	return $result;
}

sub OK {
	return 1;
}
sub NOT_OK {
	return 0;
}
1; #required