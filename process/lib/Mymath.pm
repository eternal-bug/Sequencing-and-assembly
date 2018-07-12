package Mymath;

sub sd_value{    # 求一组数的标准差
    my $value_lref = shift;
    if(ref $value_lref eq LI_TYPE){
        my $items_count = scalar(@$value_lref);
        my $add = 0;
        my $square_add = 0; # 平方和
        my $add_square = 0; # 和的平方
        for my $value (@$value_lref){
            $square_add += $value * $value;
            $add += $value;
        }
        $add_square = $add * $add;
        my $sd = sqrt(($square_add + $add_square/$items_count)/($items_count));
        return $sd;
    }
}

sub total_value{  # 求和
	my $value_lref = shift;
	if(ref $value_lref eq "ARRAY"){
		my $total;
		map {$total+=$_} @$value_lref;
		return $total;
	}
}

sub average_value{  # 平均值
    my $value_lref = shift;
    my $items_count = scalar(@$value_lref) || 1;
    my $total = &Mymath::total_value($value_lref) || 0;
    return $total/$items_count;
}

1;
