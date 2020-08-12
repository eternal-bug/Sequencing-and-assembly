package Math::Stat;
use Scalar::Util qw/looks_like_number blessed/;
use Exporter;

@EXPORT_OK = qw(new add_data get_data sd_value get_list_count sum_value average_value);  


sub new {
    my $class = shift;

    my $data = shift;
    my $self;
    if(ref $data){
        $self = {data => $data || []};
        bless $self,$class;
    }else{
        warn "Please enter list reference!!";
    }
    return $self;
}

sub add_data{
    my $self = shift;
    for my $item (@_){
        push @{$self->{'data'}},$item if Scalar::Util::looks_like_number($item);
    }
    return $self;
}

sub get_data{
    my $self = shift;
    my $type = shift;
    if(defined $self->{$type}){
        return $self->{$type};
    }else{
        warn "data is error!";
    }
}


sub sd_value{
    return &calculate_value(\&sd,@_);
}

sub sum_value{ 
    return &calculate_value(\&sum,@_);
}

sub average_value{ 
    return &calculate_value(\&average,@_);
}

sub calculate_value {
    my $sub = shift; 
    my $self = shift; 
    if(Scalar::Util::blessed($self)){
        $self->{'sum'} = $sub->($self->{"data"});
        return $self->{'sum'};
    }elsif(ref $self eq "ARRAY"){
        return $sub->($self);
    }elsif(!ref($self)){
        return $sub->([$self,@_]);
    }
}

# no OO

sub get_list_count{
    my $data_lr = shift;
    my $count = scalar(@$data_lr);
    $count > 0 ? return $count : return undef;
}

sub sum {
    my $data_lr = shift;
    my $sum;
    map {$sum+=$_} @{$data_lr};
    return $sum;
}

sub sd {
    my $data_lr = shift;
    my $items_count = &get_list_count($data_lr);
    my $add = 0;
    my $square_add = 0;
    my $add_square = 0;
    for my $value (@{$data_lr}){
        $square_add += $value * $value;
        $add += $value;
    }
    $add_square = $add * $add;
    return sqrt(($square_add + $add_square/$items_count)/($items_count));
}

sub average {
    my $data_lr = shift;
    my $total = sum_value($data_lr);
    my $items_count = &get_list_count($data_lr);
    return $total/$items_count;
}

1;
