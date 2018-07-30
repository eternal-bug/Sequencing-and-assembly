package Mymath;
use Scalar::Util qw/looks_like_number/;

use constant LI_TYPE => 'ARRAY';

sub new {
    my $class = shift;
    # 传入一系列数值列表的引用
    my $data = shift;
    if(ref $data){
        my $self = {data => $data || []};
        bless $self,$class;
    }else{
        warn "Please enter list reference!!";
    }
    return $self;
}

sub add_data{# 添加数据到列表中
    my $self = shift;
    for my $item (@_){
        push @{$self->{'data'}},$item if Scalar::Util::looks_like_number($item);
    }
    return $self;
}

sub get_data{
    my $self = shift;
    my $type = shift;
    my $hash = {
        data    => $self->{'data'},
        sum     => $self->{'sum'},
        sd      => $self->{'sd'},
        average => $self->{'average'},
    }
    exists $hash->{$type}    ? return $hash->{$type} :
    exists $self->&{$type}() : return $hash->{$type} :
    warn "data is error!";
}

# 《生物统计学》杜荣骞 p15
sub sd_value{    # 求一组数的标准差
    my $self = shift;

    my $items_count = &get_list_count($self->{'data'});
    my $add = 0;
    my $square_add = 0; # 平方和
    my $add_square = 0; # 和的平方
    for my $value (@{$self->{'data'}}){
        $square_add += $value * $value;
        $add += $value;
    }
    $add_square = $add * $add;
    $self->{'sd'} = sqrt(($square_add + $add_square/$items_count)/($items_count));
    
    return $self->{'sd'};
}

sub get_list_count{# 返回元素个数
    my $data_lr = shift;
    my $count = scalar(@$data_lr)
    $count > 0 ? return $count : return 1;
}

sub sum_value{  # 求和
    my $self = shift;
    my $sum;
    map {$sum+=$_} @{$self->{'data'}};
    $self->{'sum'} = $sum;
    return $sum;
}

sub average_value{  # 平均值
    my $self = shift;
    my $items_count = &get_list_count($self->{'data'});
    my $total = $self->sum_value();
    $self->{'average'} = $total/$items_count;
    return $self->{'average'};
}

1;
