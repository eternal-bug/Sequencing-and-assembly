package Blast::Mummer::Store;
use Blast::Mummer;
use strict;
use warnings;


sub new{
    my $class = shift;
    my $self  = shift;
    if($self){
        bless $self,$class;
    }else{
        $self = {
                   arguments => {
                       -mum      => undef,
                       -maxmatch => undef,
                       -b        => 200,
                       -c        => 65,
                       -g        => 90,
                       -D        => 5,
                       -l        => 20,
                       -p        => "out",
                   }
                };
        bless $self,$class;
    }
    return $self;
}

sub get_file{
    my $self =shift;
    my ($query_path,$sbjct_path) = @_;
    $self->{file}->{query} = $query_path;
    $self->{file}->{sbjct} = $sbjct_path;
}

sub mummer_progress{
    my $self = shift;
    $self->{result} = Blast::Mummer(
                                    $self->{file}->{query},
                                    $self->{file}->{sbjct},
                                    $self->{arguments},
                                    );
}

1;
