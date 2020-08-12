package Seq::Transform;
use strict;
use warnings;


sub seq_comp_rev{
	my $r_c_seq = &seq_com(&seq_rev(shift));
	return $r_c_seq;
}

sub seq_com{
	return shift =~ tr/AGTCagtc/TCAGtcag/r;
}

sub seq_rev{
	my $temp = reverse shift;
	return $temp;
}

sub alignment_site_reverse {
	my ($start,$end,$sequence_len) = @_;
	$start = $sequence_len - $start + 1;
	$end = $sequence_len - $end + 1;
	return ($start,$end);
}


1;
