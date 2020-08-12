package Blast::Tblastnpx::Store;
use strict;
use warnings;
use Blast::Tblastnpx;


sub new{
    my $class = shift;
    my $self  = shift;
    bless $self,$class;
}

sub getcol{
    my $self = shift;
    $self->{"col"} = shift;
}

#                          blast result
#====================================================================
#   col1    |   col2   |    col3     |       col4        |  col5    |
# -------------------------------------------------------------------
# Queryid   |  Sbjctid |   identity% |  alignmentLength  | MisMatch |
#====================================================================
#====================================================================
#   col6    |  col7   | col8  | col9    | col10 |  col11  |  col12  |
#--------------------------------------------------------------------
# GapOpening| Q.start | Q.end | S.start | S.end | E-value | BitScore|
#====================================================================

sub blast_progress{
    my $self = shift;
    my($query,$sbjct,$output) = @_;
    my ($blast_result,$blast_type) = Blast::Tblastnpx::getfile($query,$sbjct,$output);
    
    for my $result_line (split /\n/, $blast_result){
        push @{ $self->{"result"} },[(split /\t/, $result_line)[@{ $self->{"col"} }]];
    }
    if(wantarray){
        return ($self->{"result"},$blast_type);
    }else{
        return $self->{"result"};
    }
    
}

1;
