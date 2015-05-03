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
our $count = 0;
sub getStringTEST {
		shift;

		my $res = "";
		foreach (@_) {
			if (defined $_) {
				$res = $res . $_;
			}
		}
		$count += 1;
		print "In get string test /$res/\n";
		return "<m"."$count".">".$res."</m"."$count".">";	
}
sub getNothing {
	return "";
}

our $list = [];
sub addToList {
	shift;
	print "In addToList\n";
		my $res = "";
		foreach (@_) {
			if (defined $_) {
				$res = $res . $_;
			}
		}
		push @$list, $res;
		return $list;

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