package Func::Simplify;
use strict;
use warnings;
no strict 'refs';

sub simply_func_name {
    my $caller = caller;
    my ($pack,$hash_hr) = @_;
    while(my ($key,$value) = each %{$hash_hr}){
        *{$caller."::$value"} = *{$key};
    }
}

1;
