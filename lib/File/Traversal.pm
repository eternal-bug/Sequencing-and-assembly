package File::Traversal;
use strict;
use warnings;

use Clone qw/clone/;

sub new{
    my $class = shift;

    my $self = shift || {data=>[]};
    bless $self,$class;
    return $self;
}

sub add_data{
    my $self = shift;
    my $list_lr = shift;
    if(ref $list_lr eq "ARRAY"){
        push @{ $self->{"data"} },$list_lr;
    }else{
        warn "please add list reference!\n";
    }
}

sub get_file_compose{
    my $self = shift;
    my $layer = 0;
    $self->get_file_compose_recursion($layer);
}

sub get_file_compose_recursion{

    my $self = shift;
    my $layer = shift;             # layers
    my $list_new = shift || [[]];  # list acc
    my $list_temp = [];            # temp
    $layer++;

    if($layer > scalar (@{ $self->{"data"} })){
        $self->{"row"} = $list_new;
        return $self;
    }else{
        my $num = scalar (@{ $self->{"data"}->[$layer-1] });
        @$list_temp = map {
                            my @slice;
                            for my $i (0..$num-1){
                                my $temp = clone($_);
                                push @$temp,$self->{"data"}->[$layer-1]->[$i];
                                push @slice,$temp;
                            }
                            @slice;
                          } @$list_new;
        $list_new = $list_temp;
        $self->get_file_compose_recursion($layer,$list_new);
    }
}

sub update{
    my $self = shift;
    if(my $list_lr = shift @{ $self->{"row"} }){
        push @{ $self->{"cooked"} },$list_lr;
        return $list_lr;
    }else{
        return undef;
    }
}

1;
